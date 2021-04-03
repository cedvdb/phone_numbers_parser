import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';

import '../constants.dart';
import 'prefix_parser.dart';

class PhoneNumberParser {
  /// Extracts phone numbers lazily from a [text].
  static Iterable<Match> extractPotentialPhoneNumbers(String text) {
    return RegExp(Patterns.POSSIBLE_PHONE_NUMBER).allMatches(text);
  }

  /// Normalize phone number so it's only digits and possible + sign.
  ///
  /// It also converts easthern arabic digits to westhern arabic.
  ///
  /// Example:
  /// [unformatedPhoneNumber]: (+32) 0489/99.99.99
  /// Returns: +320489999999
  static String normalize(String unformatedPhoneNumber) {
    return unformatedPhoneNumber
        .split('')
        .map((char) => Patterns.allNormalizationMappings[char] ?? '')
        .join('');
  }

  static PhoneNumber parse(String rawPhoneNumber, [Country? defaultCountry]) {
    final normalized = normalize(rawPhoneNumber);
    final iddResult = PrefixParser.extractInternationalPrefix(
      normalized,
      defaultCountry,
    );
    final dialCodeResult = PrefixParser.extractDialCode(
      iddResult.phoneNumber,
      defaultCountry,
    );

    if (dialCodeResult.prefix == null) {
      throw PhoneNumberException(
          code: Code.INVALID_DIAL_CODE, description: 'not found');
    }
    final country = Country.fromDialCode(dialCodeResult.prefix!);
    final nationalNumberResult = PrefixParser.extractNationalPrefix(
      dialCodeResult.phoneNumber,
      country,
    );
    return PhoneNumber.fromCountry(country, nationalNumberResult.phoneNumber);
  }

  static String parseNationalNumber(String nationalNumber, Country country) {
    final normalized = normalize(nationalNumber);
    final extractedPrefix =
        PrefixParser.extractNationalPrefix(normalized, country);
    return extractedPrefix.phoneNumber;
  }
}
