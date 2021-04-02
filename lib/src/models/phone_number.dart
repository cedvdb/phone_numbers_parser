import 'package:phone_numbers_parser/src/parsers/country_parser.dart';
import 'package:phone_numbers_parser/src/parsers/parser2.dart';

import 'country.dart';

class PhoneNumber {
  late final String nationalNumber;
  late final Country country;

  String get dialCode => country.dialCode;

  PhoneNumber._(this.country, this.nationalNumber);

  static PhoneNumber fromRaw(String raw) => Parser.parse(raw);

  // needs to check validity
  // static PhoneNumber fromCountry(Country country, String nationalNumber);
  // needs to get the country and call from country
  PhoneNumber.fromIsoCode(String isoCode, String nationalNumber) {
    country = Country.fromIsoCode(isoCode);
    nationalNumber = Parser.parseNationalNumber(nationalNumber, country);
  }

  // needs to get the country and call from country
  PhoneNumber.fromDialCode(String dialCode, String nationalNumber) {
    country = Country.fromDialCode(dialCode);
    nationalNumber = Parser.parseNationalNumber(nationalNumber);
  }
}
