import 'dart:math';

import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/constants/constants.dart';
import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';

import '_text_parser.dart';

abstract class CountryCallingCodeParser {
  /// normalize a country calling code to return only digits
  static String normalizeCountryCallingCode(String countryCallingCode) {
    countryCallingCode = TextParser.normalize(countryCallingCode);

    if (countryCallingCode.startsWith('+')) {
      countryCallingCode = countryCallingCode.replaceFirst('+', '');
    }
    // dial code don't start with zero
    if (countryCallingCode.startsWith('0')) {
      throw PhoneNumberException(
          code: Code.INVALID_COUNTRY_CALLING_CODE,
          description: 'country calling code do not start with 0');
    }
    if (countryCallingCode.length < Constants.MIN_LENGTH_COUNTRY_CALLING_CODE ||
        countryCallingCode.length > Constants.MAX_LENGTH_COUNTRY_CALLING_CODE) {
      throw PhoneNumberException(
          code: Code.INVALID_COUNTRY_CALLING_CODE,
          description: 'country calling code invalid length');
    }
    return countryCallingCode;
  }

  /// tries to find a country calling code at the start of a phone number
  static String extractCountryCallingCode(String phoneNumber) {
    final maxLength =
        min(phoneNumber.length, Constants.MAX_LENGTH_COUNTRY_CALLING_CODE);
    var potentialCountryCode = phoneNumber.substring(0, maxLength);
    potentialCountryCode = normalizeCountryCallingCode(potentialCountryCode);
    for (var i = 1; i <= potentialCountryCode.length; i++) {
      try {
        final potentialCountryCodeFit = potentialCountryCode.substring(0, i);
        MetadataFinder.getMetadatasForCountryCallingCode(
            potentialCountryCodeFit);
        return potentialCountryCodeFit;
        // ignore: empty_catches
      } catch (e) {}
    }
    throw PhoneNumberException(
        code: Code.NOT_FOUND,
        description: 'country calling code not found in phone number');
  }

  static String removeCountryCallingCode(
      String phoneNumber, String countryCallingCode) {
    if (phoneNumber.startsWith(countryCallingCode)) {
      return phoneNumber.substring(countryCallingCode.length);
    }
    return phoneNumber;
  }
}
