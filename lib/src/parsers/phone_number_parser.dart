import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/country_phone_description.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/parsers/country_parser.dart';

import '../constants.dart';
import 'prefix_parser.dart';
import '../regexp_fix.dart';

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
  static PhoneNumber parseAsPhoneNumber(String rawPhoneNumber) {
    final country = getCountry(rawPhoneNumber);

    if (country == null) {
      throw PhoneNumberException(
          code: Code.INVALID_DIAL_CODE, description: 'not found');
    }
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

  /// gets the country a phone number originates from
  ///
  /// returns null if none can be found
  static Country? getCountry(String phoneNumber) {
    final normalized = normalize(phoneNumber);
    // 1. remove international prefix
    final iddResult = PrefixParser.extractInternationalPrefix(
      normalized,
    );
    // 2. extract country dial code and get country list
    final dialCodeResult = PrefixParser.extractDialCode(
      iddResult.phoneNumber,
    );

    if (dialCodeResult.prefix == null) {
      return null;
    }
    final nationalNumber = dialCodeResult.phoneNumber;
    final potentialCountries =
        CountryParser.listFromDialCode(dialCodeResult.prefix!);

    if (potentialCountries.length == 1) {
      return potentialCountries[0];
    }

    for (var country in potentialCountries) {
      // 3. check leading digits
      final nationalPrefix = country.phone.nationalPrefix ?? '';
      var parsedNationalNumber = nationalNumber;
      if (nationalNumber.startsWith(nationalPrefix)) {
        parsedNationalNumber = nationalNumber.substring(nationalPrefix.length);
      }
      final leadingDigits = country.phone.leadingDigits;
      if (leadingDigits != null &&
          parsedNationalNumber.startsWith(leadingDigits)) {
        return country;
      }
      // 4. attempt pattern matching
      if (getType(parsedNationalNumber, country) != null) {
        return country;
      }
    }
  }

  /// [nationalPhoneNumber] a parsed national phone number
  static PhoneNumberType? getType(String nationalPhoneNumber, Country country) {
    final validation = country.phone.validation;
    final general = validation.general;
    final fixedLine = validation.fixedLine;
    final mobile = validation.mobile;
    final length = nationalPhoneNumber.length;

    if (length < Constants.MIN_LENGTH_FOR_NSN) {
      return null;
    }

    final matchGeneralDesc =
        RegExp(general.pattern).matchEntirely(nationalPhoneNumber);
    if (matchGeneralDesc == null) {
      return null;
    }
    if (fixedLine.lengths!.contains(length) &&
        RegExp(fixedLine.pattern).matchEntirely(nationalPhoneNumber) != null) {
      return PhoneNumberType.fixedLine;
    }
    if (mobile.lengths!.contains(length) &&
        RegExp(mobile.pattern).matchEntirely(nationalPhoneNumber) != null) {
      return PhoneNumberType.fixedLine;
    }
  }
}
