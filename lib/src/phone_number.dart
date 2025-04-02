import 'package:phone_numbers_parser/src/formatting/phone_number_formatter.dart';
import 'package:phone_numbers_parser/src/range/phone_number_range.dart';
import 'package:phone_numbers_parser/src/validation/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/_text_parser.dart';
import 'package:phone_numbers_parser/src/validation/validator.dart';
import 'package:phone_numbers_parser/src/parsers/phone_parser.dart';
import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';

import 'iso_codes/iso_code.dart';

/// represents a phone number
///
/// Use [PhoneNumber.parse] to compute a phone number.
/// Use [PhoneNumber] if you know the phone number nsn and iso code
/// you can use the default constructor, this won't run any computation.
class PhoneNumber {
  /// National number in its international form
  final String nsn;

  /// country alpha2 code example: 'FR', 'US', ...
  final IsoCode isoCode;

  /// territory numerical code that precedes a phone number. Example 33 for france
  String get countryCode =>
      MetadataFinder.findMetadataForIsoCode(isoCode).countryCode;

  /// international version of phone number
  String get international => '+$countryCode$nsn';

  const PhoneNumber({
    required this.isoCode,
    required this.nsn,
  });

  /// {@template phoneNumber}
  /// Parses a phone number given caller or destination information.
  ///
  /// The logic is:
  ///
  ///  1. Remove the international prefix / exit code
  ///    a. if caller is provided remove the international prefix / exit code
  ///    b. if caller is not provided be a best guess is done with a possible destination
  ///       country
  ///  2. Find destination country
  ///    a. if no destination country was provided, the destination is assumed to be the
  ///       same as the caller
  ///    b. if no caller was provided a best guess is estimated by looking at
  ///       the first digits to see if they match a country. Since multiple countries
  ///       share the same country code, pattern matching might be used when there are
  ///       multiple matches.
  ///  3. Extract the country code with the country information
  ///  4. Transform a local NSN to an international version
  ///
  /// {@endtemplate}
  static PhoneNumber parse(
    String phoneNumber, {
    IsoCode? callerCountry,
    IsoCode? destinationCountry,
  }) =>
      PhoneParser.parse(
        phoneNumber,
        callerCountry: callerCountry,
        destinationCountry: destinationCountry,
      );

  /// formats the nsn, if no [isoCode] is provided the phone number region is used.
  String formatNsn({IsoCode? isoCode, NsnFormat format = NsnFormat.national}) =>
      PhoneNumberFormatter.formatNsn(nsn, isoCode ?? this.isoCode, format);

  String format({IsoCode? isoCode, NsnFormat format = NsnFormat.national}) {
    return '+$countryCode ${formatNsn(isoCode: isoCode, format: format)}';
  }

  @Deprecated('Use [formatNsn] instead')
  String getFormattedNsn({IsoCode? isoCode}) => formatNsn(isoCode: isoCode);

  //
  //  Validation
  //

  /// validates a phone number by first checking its length then pattern matching
  bool isValid({PhoneNumberType? type}) =>
      Validator.validateWithPattern(isoCode, nsn, type);

  /// validates a phone number by only checking its length
  bool isValidLength({PhoneNumberType? type}) =>
      Validator.validateWithLength(isoCode, nsn, type);

  //
  //  text
  //

  static Iterable<PhoneNumber> findPotentialPhoneNumbers(String text) =>
      TextParser.findPotentialPhoneNumbers(text).map((match) {
        try {
          return PhoneNumber.parse(match.group(0)!);
        } catch (e) {
          return null;
        }
      }).whereType<PhoneNumber>();

  //
  //  inequalities
  //

  static PhoneNumberRange getRange(PhoneNumber start, PhoneNumber end) =>
      PhoneNumberRange(start, end);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneNumber && other.nsn == nsn && other.isoCode == isoCode;
  }

  @override
  int get hashCode => nsn.hashCode ^ isoCode.hashCode;

  ///  numerically add [operand] to this phone number
  /// e.g.
  /// ```dart
  /// PhoneParser.parseRaw('61383208100') + 1 == PhoneParser.parseRaw('61383208101');
  /// ```
  PhoneNumber operator +(int operand) {
    final nsnLength = nsn.length;
    final resultNsn = BigInt.parse(nsn) + BigInt.from(operand);
    return PhoneNumber(
      isoCode: isoCode,
      nsn: resultNsn.toString().padLeft(nsnLength, '0'),
    );
  }

  /// numerically subtract [operand] from this phone number
  /// e.g.
  /// ```dart
  /// PhoneParser.parseRaw('61383208100') - 1 == PhoneParser.parseRaw('61383208099');
  /// ```
  PhoneNumber operator -(int operand) {
    final nsnLength = nsn.length;
    final resultNsn = BigInt.parse(nsn) - BigInt.from(operand);
    return PhoneNumber(
      isoCode: isoCode,
      nsn: resultNsn.toString().padLeft(nsnLength, '0'),
    );
  }

  /// Returns true if this phone number is numerically greater
  /// than [other]
  bool operator >(PhoneNumber other) {
    var selfAsNum = BigInt.parse(international);
    var otherAsNum = BigInt.parse(other.international);

    return (selfAsNum - otherAsNum).toInt() > 0;
  }

  /// Returns true if this phone number is numerically greater
  /// than or equal to [other]
  bool operator >=(PhoneNumber other) {
    return this == other || this > other;
  }

  /// Returns true if this phone number is numerically less
  /// than [other]
  bool operator <(PhoneNumber rhs) {
    return !(this >= rhs);
  }

  /// Returns true if this phone number is numerically less
  /// than or equal to [other]
  bool operator <=(PhoneNumber rhs) {
    return this < rhs || (this == rhs);
  }

  /// We consider the PhoneNumber to be adjacent to the this PhoneNumber if it is one less or one greater than this
  ///  phone number.
  bool isAdjacentTo(PhoneNumber other) {
    return ((this + 1) == other) || ((this - 1) == other);
  }

  /// Returns true if [nextNumber] is the next number (numerically) after this number
  /// ```dart
  /// PhoneParser.parseRaw('61383208100').isSequentialTo( PhoneParser.parseRaw('61383208101')) == true;
  /// ```
  bool isSequentialTo(PhoneNumber nextNumber) {
    return ((this + 1) == nextNumber);
  }

  @override
  String toString() =>
      'PhoneNumber(isoCode: $isoCode, countryCode: $countryCode, nsn: $nsn)';

  Map<String, dynamic> toJson() {
    return {
      'isoCode': isoCode.name,
      'nsn': nsn,
    };
  }

  factory PhoneNumber.fromJson(Map<String, dynamic> map) {
    return PhoneNumber(
      isoCode: IsoCode.values.byName(map['isoCode']),
      nsn: map['nsn'] ?? '',
    );
  }
}
