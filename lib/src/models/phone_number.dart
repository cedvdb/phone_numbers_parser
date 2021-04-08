import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/validator.dart';

import '../parsers/phone_number_parser.dart';
import 'country.dart';

/// Represents a phone number.
///
/// To know if a phone number is valid you can check the [valid] property.
///
/// The [international] property gives you a format that can be used to call
/// a phone number.
class PhoneNumber {
  /// The country this phone number originates from
  final Country country;

  /// The national number given as input, marked as private atm
  /// because it could lead to confusion
  final String _national;

  /// The national number transformed for international use
  final String nsn;

  /// Whether this phone number is valid for its country
  late final bool valid;

  String get dialCode => country.dialCode;
  String get isoCode => country.isoCode;
  String get international => '+' + dialCode + nsn;

  PhoneNumber._(this.country, this.nsn, this._national) {
    valid = Validator.isValidNationalNumber(nsn, country.phone);
  }

  /// Creates a [PhoneNumber] from a [rawPhoneNumber],
  ///
  /// [rawPhoneNumber] is expected to be a phone number containing the
  /// country code. Various formats and even easthern arabic numberals
  /// are accepted.
  ///
  /// For example:
  ///  - +33 93 987 6218
  ///  - (+33) 93.987.6218
  ///
  /// You can use an international prefix if that prefix is 00 or 011
  /// For example:
  ///  - 00 33 93 987 6218
  ///
  /// Note that this method should not be used to find a phone number in
  /// text, for that use [PhoneNumberUtil.findPotentialPhoneNumber]
  ///
  /// throws a [PhoneNumberException] if the country the phone number originates
  /// from cannot be found. If you know the country in advance use [fromIsoCode].
  static PhoneNumber fromRaw(String rawPhoneNumber) {
    final normalized = PhoneNumberUtil.normalize(rawPhoneNumber);
    return PhoneNumberParser.parse(normalized);
  }

  /// Creates a [PhoneNumber] with an isoCode or a nationalNumber
  ///
  /// {@template nationalNumber}
  ///
  /// The [nationalNumber] is the national part of a phone number.
  /// For example for the international phone number +33 93 987 6218
  /// the nationalNumber would be 93 987 6218, or alternatively
  /// with the prefix 0 93 987 6218.
  ///
  /// Note that [PhoneNumber.nsn] does not necessarily equal nationalNumber,
  /// as some manipulation is done on it to make it valid internationally.
  /// {@endtemplate}
  ///
  /// If the [isoCode] is invalid, throws a [PhoneNumberException]
  static PhoneNumber fromIsoCode(String isoCode, String nationalNumber) {
    final normalized = PhoneNumberUtil.normalize(nationalNumber);
    return PhoneNumberParser.parseWithIsoCode(normalized, isoCode);
  }

  /// Creates a phone number with a [dialCode] and a [nationalNumber].
  ///
  /// {@macro nationalNumber}
  ///
  /// Note that if you know the country in advance, you should use the
  /// [fromIsoCode] method as it will require less parsing, and potentially
  /// avoid mistakes.
  ///
  /// If the [dialCode] is invalid, throws a [PhoneNumberException]
  static PhoneNumber fromDialCode(String dialCode, String nationalNumber) {
    final normalized = PhoneNumberUtil.normalize(nationalNumber);
    return PhoneNumberParser.parseWithDialCode(normalized, dialCode);
  }

  /// This method does not transform the national number and should
  /// be used mainly by the library
  static PhoneNumber fromCountry(
      Country country, String nsn, String nationalNumber) {
    return PhoneNumber._(country, nsn, nationalNumber);
  }

  PhoneNumber copyWithIsoCode(String isoCode) {
    return PhoneNumberParser.parseWithIsoCode(_national, dialCode);
  }

  @override
  String toString() =>
      'PhoneNumber(nsn: $nsn, country: $country, valid: $valid)';
}
