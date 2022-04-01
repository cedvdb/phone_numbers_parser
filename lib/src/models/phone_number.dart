import 'dart:convert';

import 'package:dart_countries/dart_countries.dart';
import 'package:phone_numbers_parser/src/formatters/phone_number_formatter.dart';
import 'package:phone_numbers_parser/src/models/phone_number_range.dart';
import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/_text_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_validator.dart';
import 'package:phone_numbers_parser/src/parsers/phone_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';

/// represents a phone number
///
/// Use one of the static method starting with 'from' in order to
/// return a [PhoneNumber] that has been parsed to it's international version.
///
class PhoneNumber {
  /// National number in its internanational form
  final String nsn;

  /// country alpha2 code example: 'FR', 'US', ...
  final IsoCode isoCode;

  /// territory numerical code that precedes a phone number. Example 33 for france
  String get countryCode =>
      MetadataFinder.getMetadataForIsoCode(isoCode).countryCode;

  /// international version of phone number
  String get international => '+' + countryCode + nsn;

  const PhoneNumber({
    required this.isoCode,
    required this.nsn,
  });

  //
  //  Creation
  //

  /// Parses a [national] phone number given a country code and returns
  /// a [PhoneNumber]
  ///
  /// This is useful for when you know in advance that a phone
  /// number is a national version.
  /// For example in a phone number input with two inputs for the
  /// iso code and national number
  ///
  /// alias for [PhoneParser.fromNational]
  static PhoneNumber fromNational(
    IsoCode isoCode,
    String national,
  ) =>
      PhoneParser.fromNational(isoCode, national);

  /// Parses a [phoneNumber] given a [countryCode]
  ///
  /// Use [fromIsoCode] when possible as multiple countries
  /// use the same country calling code.
  ///
  /// If you know the [phoneNumber] is a national number,
  /// prefer [fromNational].
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the country calling code is invalid
  ///
  /// alias for [PhoneParser.fromCountryCode]
  static PhoneNumber fromCountryCode(
    String countryCode,
    String phoneNumber,
  ) =>
      PhoneParser.fromCountryCode(countryCode, phoneNumber);

  /// Parses a [phoneNumber] given an [isoCode]
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the isoCode is invalid
  static PhoneNumber fromIsoCode(
    IsoCode isoCode,
    String phoneNumber,
  ) =>
      PhoneParser.fromIsoCode(isoCode, phoneNumber);

  /// Parses a [phoneNumber] given a [countryCode]
  ///
  /// Use [fromIsoCode] when possible as multiple countries
  /// use the same country calling code.
  ///
  /// This method assumes the phone number starts with the country calling code
  ///
  /// throws a PhoneNumberException if the country calling code is invalid
  static PhoneNumber fromRaw(String phoneNumber) =>
      PhoneParser.fromRaw(phoneNumber);

  /// reparse phone number with new values
  PhoneNumber rebuildWith({IsoCode? isoCode, String? nsn}) =>
      PhoneParser.fromIsoCode(
        isoCode ?? this.isoCode,
        nsn ?? this.nsn,
      );

  //
  //  Formatting
  //

  /// formats the national phone number to the format expected by the iso code
  /// region
  String getFormattedNsn() => PhoneNumberFormatter.formatNsn(this);

  //
  //  Validation
  //

  /// validates a phone number by first checking its length then pattern matching
  bool validate({PhoneNumberType? type}) =>
      Validator.validateWithPattern(this, type);

  /// validates a phone number by only checking its length
  bool validateLength({PhoneNumberType? type}) =>
      Validator.validateWithLength(this, type);

  //
  //  text
  //

  static Iterable<Match> findPotentialPhoneNumbers(String text) =>
      TextParser.findPotentialPhoneNumbers(text);

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
    var self = BigInt.parse(international);
    var _other = BigInt.parse(other.international);

    return (self - _other).toInt() > 0;
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

  Map<String, dynamic> toMap() {
    return {
      'isoCode': isoCode.name,
      'nsn': nsn,
    };
  }

  factory PhoneNumber.fromMap(Map<String, dynamic> map) {
    return PhoneNumber(
      isoCode: IsoCode.values.byName(map['isoCode']),
      nsn: map['nsn'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneNumber.fromJson(String source) =>
      PhoneNumber.fromMap(json.decode(source));
}
