import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';

import '../constants.dart';
import 'prefix_parser.dart';

/// Parser to do various operations on Strings representing phone numbers.
class PhoneNumberParser {
  /// Extracts phone numbers from a [text].
  static Iterable<Match> findPotentialPhoneNumbers(String text) {
    // we dont check if it is a valid phone number, a date or anything else.
    // the user can parse the phone number to check validity
    return RegExp(Constants.POSSIBLE_PHONE_NUMBER).allMatches(text);
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
        .map((char) => Constants.allNormalizationMappings[char] ?? '')
        .join('');
  }

  /// Extracts the necessary information from [rawPhoneNumber] to return [PhoneNumber].
  ///
  /// The [rawPhoneNumber] is expected to contain the country dial code
  ///
  /// Throws [PhoneNumberException].
  static PhoneNumber parse(String rawPhoneNumber) {
    final normalized = normalize(rawPhoneNumber);
    final iddResult = PrefixParser.extractInternationalPrefix(
      normalized,
    );
    final dialCodeResult = PrefixParser.extractDialCode(
      iddResult.phoneNumber,
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

  /// Parses a [nationalNumber] by normalizing it and keeping only the
  /// significants digits.
  static String parseNationalNumber(String nationalNumber, Country country) {
    final normalized = normalize(nationalNumber);
    final extractedPrefix =
        PrefixParser.extractNationalPrefix(normalized, country);
    return extractedPrefix.phoneNumber;
  }

  static Country getCountry(String phoneNumber) {
    final normalized = normalize(phoneNumber);
    final iddResult = PrefixParser.extractInternationalPrefix(
      phoneNumber,
    );
    final dialCodeResult = PrefixParser.extractDialCode(
      iddResult.phoneNumber,
    );
    throw 'unimplemented';
  }
}
