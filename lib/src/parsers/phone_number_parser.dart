import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/country_phone_description.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/parsers/country_parser.dart';

import '../constants.dart';
import 'extractor.dart';
import '../regexp_fix.dart';

// This class mainly contains the public api. The methods body here
// are mainly summaries of what happens and use the [PrefixParser]
// to do the parsing business logic
// Therefor this class must stay clean as to be readable as almost plain english

/// Parser to do various operations on Strings representing phone numbers.
class PhoneNumberParser {
  /// Extracts phone numbers from a [text].
  /// The potential phone numbers returned are not checked for their validity.
  /// It is possible that a match could be a date or anything else ressembling a phone number.
  /// To verify it is in fact a phone number you can parse it and check its validity
  static Iterable<Match> findPotentialPhoneNumbers(String text) {
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
  /// The [rawPhoneNumber] is expected to contain the country dial code.
  /// It will return a valid result if the [rawPhoneNumber] start with +, 00 or 011
  /// as international prefix.
  ///
  /// If the phoneNumber does not contain a country dial code, use [parseNational]
  ///
  /// Throws [PhoneNumberException].
  static PhoneNumber parse(String rawPhoneNumber) {
    final normalized = normalize(rawPhoneNumber);
    final internationalPrefixResult =
        Extractor.extractInternationalPrefix(normalized);
    final dialCodeResult = Extractor.extractDialCode(
      internationalPrefixResult.phoneNumber,
    );

    if (dialCodeResult.extracted == null) {
      throw PhoneNumberException(
        code: Code.INVALID_DIAL_CODE,
        description: 'not found',
      );
    }

    final countryResult = Extractor.extractCountry(
      dialCodeResult.phoneNumber,
      dialCodeResult.extracted!,
    );

    if (countryResult.extracted == null) {
      throw PhoneNumberException(
        code: Code.INVALID_DIAL_CODE,
        description: 'The country could not be guessed',
      );
    }
    return PhoneNumber.fromCountry(
      countryResult.extracted!,
      countryResult.phoneNumber,
    );
  }

  /// Converts a [nationalNumber] by normalizing it and keeping only the
  /// significants digits.
  static String parseNationalNumber(String nationalNumber, Country country) {
    final normalized = normalize(nationalNumber);
    final extractedPrefix =
        Extractor.extractNationalPrefix(normalized, country);
    return extractedPrefix.phoneNumber;
  }
}
