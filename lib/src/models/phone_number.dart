import 'package:phone_numbers_parser/src/validator.dart';

import '../parsers/phone_number_parser.dart';
import 'country.dart';

class PhoneNumber {
  late final String nationalNumber;
  late final Country country;
  late final bool valid;

  String get dialCode => country.dialCode;

  PhoneNumber._(this.country, this.nationalNumber) {
    valid = Validator.isValidNationalNumber(nationalNumber, country.phone);
  }

  static PhoneNumber fromRaw(String raw) => PhoneNumberParser.parse(raw);

  static PhoneNumber fromIsoCode(String isoCode, String nationalNumber) {
    final country = Country.fromIsoCode(isoCode);
    nationalNumber =
        PhoneNumberParser.parseNationalNumber(nationalNumber, country);
    return PhoneNumber._(country, nationalNumber);
  }

  static PhoneNumber fromDialCode(String dialCode, String nationalNumber) {
    final country = Country.fromDialCode(dialCode);
    nationalNumber =
        PhoneNumberParser.parseNationalNumber(nationalNumber, country);
    return PhoneNumber._(country, nationalNumber);
  }

  static PhoneNumber fromCountry(Country country, String nationalNumber) {
    nationalNumber =
        PhoneNumberParser.parseNationalNumber(nationalNumber, country);
    return PhoneNumber._(country, nationalNumber);
  }
}
