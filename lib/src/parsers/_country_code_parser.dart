import 'dart:math';

import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/constants/constants.dart';
import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';

import '_text_parser.dart';

abstract class CountryCodeParser {
  /// normalize a country calling code to return only digits
  static String normalizeCountryCode(String countryCode) {
    countryCode = TextParser.normalize(countryCode);

    if (countryCode.startsWith('+')) {
      countryCode = countryCode.replaceFirst('+', '');
    }
    // country code don't start with zero
    if (countryCode.startsWith('0')) {
      throw PhoneNumberException(
          code: Code.INVALID_COUNTRY_CALLING_CODE,
          description:
              'country calling code do not start with 0, was $countryCode');
    }
    if (int.tryParse(countryCode) == null) {
      throw PhoneNumberException(
          code: Code.INVALID_COUNTRY_CALLING_CODE,
          description: 'country calling code must be digits, was $countryCode. '
              'Maybe you wanted to parse with isoCode ?');
    }
    if (countryCode.length < Constants.MIN_LENGTH_COUNTRY_CALLING_CODE ||
        countryCode.length > Constants.MAX_LENGTH_COUNTRY_CALLING_CODE) {
      throw PhoneNumberException(
          code: Code.INVALID_COUNTRY_CALLING_CODE,
          description:
              'country calling code has an invalid length, was $countryCode');
    }
    return countryCode;
  }

  /// tries to find a country calling code at the start of a phone number
  static String extractCountryCode(String phoneNumber) {
    final maxLength =
        min(phoneNumber.length, Constants.MAX_LENGTH_COUNTRY_CALLING_CODE);
    var potentialCountryCode = phoneNumber.substring(0, maxLength);
    potentialCountryCode = normalizeCountryCode(potentialCountryCode);
    for (var i = 1; i <= potentialCountryCode.length; i++) {
      try {
        final potentialCountryCodeFit = potentialCountryCode.substring(0, i);
        MetadataFinder.getMetadatasForCountryCode(potentialCountryCodeFit);
        return potentialCountryCodeFit;
        // ignore: empty_catches
      } catch (e) {}
    }
    throw PhoneNumberException(
        code: Code.NOT_FOUND,
        description:
            'country calling code not found in phone number $phoneNumber');
  }

  static String removeCountryCode(String phoneNumber, String countryCode) {
    if (phoneNumber.startsWith(countryCode)) {
      return phoneNumber.substring(countryCode.length);
    }
    return phoneNumber;
  }
}
