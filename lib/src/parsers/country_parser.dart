import '../exceptions.dart';
import 'package:dart_countries/dart_countries.dart';

class CountryParser {
  static Country fromIsoCode(String isoCode) {
    final found = countriesByIsoCode[isoCode.toUpperCase()];
    if (found != null) {
      return found;
    }
    throw PhoneNumberException(
      code: Code.INVALID_ISO_CODE,
      description: 'isoCode "$isoCode" not found',
    );
  }

  static Country fromDialCode(String dialCode) {
    return listFromDialCode(dialCode)[0];
  }

  static List<Country> listFromDialCode(String dialCode) {
    if (dialCode.startsWith('+')) {
      dialCode = dialCode.substring(1);
    }
    final countries = countriesByDialCode[dialCode];
    if (countries != null) {
      return countries;
    }
    throw PhoneNumberException(
      code: Code.INVALID_DIAL_CODE,
      description: 'dialCode $dialCode not found',
    );
  }
}
