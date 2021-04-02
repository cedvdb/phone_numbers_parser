import 'dart:math';

import 'package:phone_numbers_parser/src/constants.dart';
import 'package:phone_numbers_parser/src/generated/countries_by_dial_code_map.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/country_phone_description.dart';
import 'package:phone_numbers_parser/src/validator.dart';

import '../exceptions.dart';

class PrefixParser {
  static String extractCountryCode(
    String phoneNumber, [
    Country? country,
  ]) {
    String? result;
    // Country dial codes do not begin with a '0'.
    if (phoneNumber.isEmpty || phoneNumber.startsWith('0')) {
      if (country != null) {
        result = country.dialCode;
      }
    } else {
      String potentialCountryCode;
      final numberLength = phoneNumber.length;
      final max = min(numberLength, Patterns.MAX_LENGTH_COUNTRY_DIAL_CODE);
      for (var i = 1; i <= max; i++) {
        potentialCountryCode = phoneNumber.substring(0, i);
        if (countriesByDialCode.containsKey(potentialCountryCode)) {
          result = potentialCountryCode;
        }
      }
    }
    if (result != null || country != null) {
      return result ?? country!.dialCode;
    }
    throw PhoneNumberException(
      code: Code.INVALID_DIAL_CODE,
      description: 'country dial code not found',
    );
  }

  static String stipInternationalPrefix(
    String normalizedPhoneNumber, [
    Country? country,
  ]) {
    return _extractInternationalPrefix(normalizedPhoneNumber, country)[0];
  }

  static List<String> _extractInternationalPrefix(
    String normalizedPhoneNumber,
    Country? country,
  ) {
    if (normalizedPhoneNumber.startsWith('+')) {
      return [normalizedPhoneNumber.substring(1)];
    }

    // extract to fn
    if (country != null) {
      return _stripInternationalPrefixFromDefaultCountry(
        normalizedPhoneNumber,
        country,
      );
    }

    // 4/5 of the world wide numbers start with 00 or 011
    if (normalizedPhoneNumber.startsWith('00')) {
      return [normalizedPhoneNumber.substring(2), '00'];
    }

    if (normalizedPhoneNumber.startsWith('011')) {
      return [normalizedPhoneNumber.substring(3), '011'];
    }

    throw PhoneNumberException(
      code: Code.INVALID,
      description: 'international prefix could not be guessed',
    );
  }

  static List<String> _stripInternationalPrefixFromDefaultCountry(
    String phoneNumberDigitsOnly,
    Country country,
  ) {
    final match = RegExp(country.phone.internationalPrefix)
        .matchAsPrefix(phoneNumberDigitsOnly);
    if (match != null) {
      final internationalPrefix = phoneNumberDigitsOnly.substring(0, match.end);

      if (phoneNumberDigitsOnly.length == internationalPrefix.length) {
        throw PhoneNumberException(code: Code.INVALID);
      }
      final phoneNumber = phoneNumberDigitsOnly.substring(match.end + 1);
      return [phoneNumber, internationalPrefix];
    }
    // if it does not start with the international prefix from the
    // country we assume the prefix is not present
    return [phoneNumberDigitsOnly, country.phone.internationalPrefix];
  }

  // TODO remove extract if not needed
  static String stripNationalPrefix(String nationalNumber, Country country) {
    return _extractNationalPrefix(nationalNumber, country)[0];
  }

  /// removes the national prefix of a national number
  static List<String> _extractNationalPrefix(
    String nationalNumber,
    Country country,
  ) {
    final pattern = country.phone.nationalPrefix;
    if (pattern == null) {
      return [nationalNumber];
    }
    final match = RegExp(pattern).matchAsPrefix(nationalNumber);
    if (match == null) {
      return [nationalNumber];
    }
    final transformRule = country.phone.nationalPrefixTransformRule;
    // if there is no group caught there is no need to transform
    if (transformRule == null || match.groupCount == 0) {
      final result = _pickBestNationalNumber(
        nationalNumber,
        nationalNumber.substring(match.end),
        country.phone,
      );
      return result == nationalNumber
          ? [result]
          : [result, nationalNumber.substring(0, match.end)];
    }
    // I did not find a built in way of replacing a match with a template so
    // let's do it by hand
    var transformed = transformRule.replaceFirst(r'$1', match.group(1)!);
    if (match.groupCount > 1) {
      transformed = transformed.replaceFirst(r'$2', match.group(2)!);
    }
    final result =
        _pickBestNationalNumber(nationalNumber, transformed, country.phone);
    return result == nationalNumber
        ? [result]
        : [result, nationalNumber.substring(0, match.end)];
  }

  static String _pickBestNationalNumber(
    String originalNationalNumber,
    String newNationalNumber,
    CountryPhoneDescription desc,
  ) {
    final isOriginalViable = Validator.isValidNationalNumber(
      originalNationalNumber,
      desc,
    );
    final isNewNationalNumberViable = Validator.isValidNationalNumber(
      newNationalNumber,
      desc,
    );
    if (isNewNationalNumberViable) {
      return newNationalNumber;
    }
    if (isOriginalViable) {
      return originalNationalNumber;
    }
    throw PhoneNumberException(
      code: Code.INVALID,
      description: 'The phone number is not valid for this country',
    );
  }
}
