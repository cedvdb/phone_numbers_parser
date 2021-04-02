import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/resources/file_generation/base_country_by_dial_code.dart';
import 'package:phone_numbers_parser/src/generated/countries_by_iso_code_map.dart';
import 'package:phone_numbers_parser/src/models/country.dart';

class CountryParser {
  static Country fromIsoCode(String isoCode) {
    final found = countriesByIsoCode[isoCode.toUpperCase()];
    if (found != null) {
      return found;
    }
    throw PhoneNumberException(code: Code.INVALID_ISO_CODE);
  }

  static Country fromDialCode(String dialCode) {
    if (dialCode.startsWith('+')) {
      dialCode = dialCode.substring(1);
    }
    final countries = countriesByDialCode[dialCode];
    if (countries != null) {
      return countries[0];
    }
    throw PhoneNumberException(code: Code.INVALID_DIAL_CODE);
  }
}
