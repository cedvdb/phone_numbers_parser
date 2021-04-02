import 'package:phone_numbers_parser/resources/file_generation/base_country_by_dial_code.dart';
import 'package:phone_numbers_parser/src/exceptions.dart';
import 'package:phone_numbers_parser/src/generated/countries_by_iso_code_map.dart';
import 'package:phone_numbers_parser/src/models/country_phone_description.dart';
import 'package:phone_numbers_parser/src/parsers/country_parser.dart';

/// Country regroup informations for displaying a list of countries
class Country {
  /// English name of the country
  final String name;

  /// emoji flag
  final String flag;

  /// short country code
  final String isoCode;

  /// description of what the phone number should look like
  final CountryPhoneDescription phone;

  /// country dialing code to call them internationally
  String get dialCode => phone.dialCode;

  const Country({
    required this.name,
    required this.flag,
    required this.isoCode,
    required this.phone,
  });

  @override
  String toString() {
    return 'Country(name: $name, flag: $flag, isoCode: $isoCode, phone: $phone)';
  }

  static Country fromIsoCode(String isoCode) =>
      CountryParser.fromIsoCode(isoCode);

  static Country fromDialCode(String dialCode) =>
      CountryParser.fromDialCode(dialCode);
}
