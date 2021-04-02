import 'package:phone_numbers_parser/src/models/country.dart';

import '../generated/countries_by_dial_code_map.dart';

import '../constants.dart';
import '../exceptions.dart';
import '../models/phone_number.dart';
import 'prefix_parser.dart';

class Parser {
  static int maxInputLength = 250;

  static Iterable<Match> extractPotentialPhoneNumbers(String text) {
    if (text.length > maxInputLength) {
      throw PhoneNumberException(code: Code.INPUT_IS_TOO_LONG);
    }
    return RegExp(Patterns.POSSIBLE_PHONE_NUMBER).allMatches(text);
  }

  static PhoneNumber parse(String rawPhoneNumber, [Country? defaultCountry]) {
    final normalized = _normalize(rawPhoneNumber);
    final phoneNumber = PrefixParser.stipInternationalPrefix(
      normalized,
      defaultCountry,
    );
    final countryCode = PrefixParser.extractCountryCode(
      phoneNumber,
      defaultCountry,
    );
    // we get the first country for this dial code,
    // which is the main country for this dial code.
    final country = countriesByDialCode[countryCode]![0];
    final nationalNumberWithPrefix = phoneNumber.substring(countryCode.length);
    final nationalNumber = PrefixParser.stripNationalPrefix(
      nationalNumberWithPrefix,
      country,
    );
    return PhoneNumber(nationalNumber, country);
  }

  static String _normalize(String rawPhoneNumber) {
    final firstMatch =
        extractPotentialPhoneNumbers(rawPhoneNumber).first.group(0);
    if (firstMatch == null) {
      throw PhoneNumberException(code: Code.NOT_FOUND);
    }

    return _toPlusAndDigitsOnly(firstMatch);
  }

  static String _toPlusAndDigitsOnly(String string) {
    return string
        .split('')
        .map((char) => Patterns.allNormalizationMappings[char] ?? '')
        .join('');
  }
}
