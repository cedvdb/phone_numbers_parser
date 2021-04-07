import 'package:phone_numbers_parser/src/parsers/validator.dart';

import '../parsers/phone_number_parser.dart';
import 'country.dart';

class PhoneNumber {
  late final String nsn;
  late final Country country;
  late final bool valid;

  String get dialCode => country.dialCode;
  String get isoCode => country.isoCode;
  String get international => '+' + dialCode + nsn;

  PhoneNumber._(this.country, this.nsn) {
    valid = Validator.isValidNationalNumber(nsn, country.phone);
  }

  static PhoneNumber fromRaw(String rawPhoneNumber) {
    final normalized = PhoneNumberParser.normalize(rawPhoneNumber);
    return PhoneNumberParser.parse(normalized);
  }

  static PhoneNumber fromIsoCode(String isoCode, String nationalNumber) {
    final normalized = PhoneNumberParser.normalize(nationalNumber);
    return PhoneNumberParser.parseWithIsoCode(normalized, isoCode);
  }

  static PhoneNumber fromDialCode(String dialCode, String nationalNumber) {
    final normalized = PhoneNumberParser.normalize(nationalNumber);
    return PhoneNumberParser.parseWithDialCode(normalized, dialCode);
  }

  /// This method does not transform the national number
  static PhoneNumber fromCountry(Country country, String nationalNumber) {
    return PhoneNumber._(country, nationalNumber);
  }
}
