import 'dart:math';

import 'package:phone_numbers_parser/src/constants.dart';
import 'package:phone_numbers_parser/src/generated/countries_by_dial_code_map.dart';
import 'package:phone_numbers_parser/src/models/country.dart';

class PrefixParsingResult {
  String phoneNumber;
  String? prefix;

  PrefixParsingResult({
    this.prefix,
    required this.phoneNumber,
  });
}

/// Responsible of extracting different parts of a phone number.
///
/// It can extract the international prefix, dial code and national prefix.
class PrefixParser {
  /// expects a phone number starting with the country code
  static PrefixParsingResult extractDialCode(
    String phoneNumber, [
    Country? country,
  ]) {
    var dialCode = country?.dialCode;
    // Country dial codes do not begin with a '0'.
    if (phoneNumber.isNotEmpty || !phoneNumber.startsWith('0')) {
      String potentialCountryCode;
      final numberLength = phoneNumber.length;
      final max = min(numberLength, Patterns.MAX_LENGTH_COUNTRY_DIAL_CODE);
      for (var i = 1; i <= max; i++) {
        potentialCountryCode = phoneNumber.substring(0, i);
        if (countriesByDialCode.containsKey(potentialCountryCode)) {
          dialCode = potentialCountryCode;
        }
      }
    }
    return PrefixParsingResult(
      phoneNumber: phoneNumber.substring(dialCode!.length),
      prefix: dialCode,
    );
  }

  static PrefixParsingResult extractInternationalPrefix(
    String phoneNumber,
    Country? country,
  ) {
    if (phoneNumber.startsWith('+')) {
      return PrefixParsingResult(
        phoneNumber: phoneNumber.substring(1),
      );
    }

    // extract to fn
    if (country != null) {
      return _stripInternationalPrefixFromDefaultCountry(
        phoneNumber,
        country,
      );
    }

    // 4/5 of the world wide numbers start with 00 or 011
    if (phoneNumber.startsWith('00')) {
      return PrefixParsingResult(
          phoneNumber: phoneNumber.substring(2), prefix: '00');
    }

    if (phoneNumber.startsWith('011')) {
      return PrefixParsingResult(
          phoneNumber: phoneNumber.substring(3), prefix: '011');
    }

    return PrefixParsingResult(phoneNumber: phoneNumber);
  }

  static PrefixParsingResult _stripInternationalPrefixFromDefaultCountry(
    String phoneNumber,
    Country country,
  ) {
    final match =
        RegExp(country.phone.internationalPrefix).matchAsPrefix(phoneNumber);
    if (match != null) {
      final internationalPrefix = phoneNumber.substring(0, match.end);
      return PrefixParsingResult(
        phoneNumber: phoneNumber.substring(match.end + 1),
        prefix: internationalPrefix,
      );
    }
    // if it does not start with the international prefix from the
    // country we assume the prefix is not present
    return PrefixParsingResult(
      phoneNumber: phoneNumber,
      prefix: country.phone.internationalPrefix,
    );
  }

  /// removes the national prefix of a national number
  static PrefixParsingResult extractNationalPrefix(
    String nationalNumber,
    Country country,
  ) {
    final pattern = country.phone.nationalPrefix;
    if (pattern == null) {
      return PrefixParsingResult(phoneNumber: nationalNumber);
    }
    final match = RegExp(pattern).matchAsPrefix(nationalNumber);
    if (match == null) {
      return PrefixParsingResult(phoneNumber: nationalNumber);
    }
    final transformRule = country.phone.nationalPrefixTransformRule;
    // if there is no group caught there is no need to transform
    if (transformRule == null || match.groupCount == 0) {
      return PrefixParsingResult(
        phoneNumber: nationalNumber.substring(match.end),
        prefix: nationalNumber.substring(0, match.end),
      );
    }
    // I did not find a built in way of replacing a match with a template so
    // let's do it by hand
    var transformed = transformRule.replaceFirst(r'$1', match.group(1)!);
    if (match.groupCount > 1) {
      transformed = transformed.replaceFirst(r'$2', match.group(2)!);
    }
    return PrefixParsingResult(
      phoneNumber: transformed,
      prefix: nationalNumber.substring(0, match.end),
    );
  }
}
