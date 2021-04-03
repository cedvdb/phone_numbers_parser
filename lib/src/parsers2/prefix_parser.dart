import 'dart:math';

import 'package:phone_numbers_parser/src/constants.dart';
import 'package:phone_numbers_parser/src/generated/countries_by_dial_code_map.dart';
import 'package:phone_numbers_parser/src/models/country.dart';

class ExtractionResult {
  String phoneNumber;
  String? prefix;

  ExtractionResult({
    this.prefix,
    required this.phoneNumber,
  });
}

/// Responsible of extracting different parts of a phone number.
///
/// It can extract the international prefix, dial code and national prefix.
class PrefixParser {
  /// Extracts the country dial code from a [phoneNumber].
  ///
  /// It expects a normalized [phoneNumber] starting
  /// with the country code and without the +.
  static ExtractionResult extractDialCode(
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
    return ExtractionResult(
      phoneNumber: phoneNumber.substring(dialCode!.length),
      prefix: dialCode,
    );
  }

  /// extract the international prefix of a phone number if present.
  ///
  /// It expects a normalized [phoneNumber].
  ///
  ///  - if [phoneNumber] starts with +, there is no prefix
  ///  - else if a [defaultCountry] is given the prefix is from defaultCountry
  ///  - else if starts with 00 or 011
  ///    we consider those as internationalPrefix as
  ///    they cover 4/5 of the international prefix
  static ExtractionResult extractInternationalPrefix(
    String phoneNumber,
    Country? country,
  ) {
    if (phoneNumber.startsWith('+')) {
      return ExtractionResult(
        phoneNumber: phoneNumber.substring(1),
      );
    }

    // extract to fn
    if (country != null) {
      return _extractInternationalPrefixFromDefaultCountry(
        phoneNumber,
        country,
      );
    }

    // 4/5 of the world wide numbers start with 00 or 011
    if (phoneNumber.startsWith('00')) {
      return ExtractionResult(
          phoneNumber: phoneNumber.substring(2), prefix: '00');
    }

    if (phoneNumber.startsWith('011')) {
      return ExtractionResult(
          phoneNumber: phoneNumber.substring(3), prefix: '011');
    }

    return ExtractionResult(phoneNumber: phoneNumber);
  }

  static ExtractionResult _extractInternationalPrefixFromDefaultCountry(
    String phoneNumber,
    Country country,
  ) {
    final match =
        RegExp(country.phone.internationalPrefix).matchAsPrefix(phoneNumber);
    if (match != null) {
      return ExtractionResult(
        phoneNumber: phoneNumber.substring(match.end + 1),
        prefix: phoneNumber.substring(0, match.end),
      );
    }
    // if it does not start with the international prefix from the
    // country we assume the prefix is not present
    return ExtractionResult(
      phoneNumber: phoneNumber,
    );
  }

  /// extract the national prefix of a [nationalNumber] and applies possible
  /// transformation to the nationalNumber which is reflected in the result.phoneNumber
  static ExtractionResult extractNationalPrefix(
    String nationalNumber,
    Country country,
  ) {
    final pattern = country.phone.nationalPrefix;
    if (pattern == null) {
      return ExtractionResult(phoneNumber: nationalNumber);
    }
    final match = RegExp(pattern).matchAsPrefix(nationalNumber);
    if (match == null) {
      return ExtractionResult(phoneNumber: nationalNumber);
    }
    final transformRule = country.phone.nationalPrefixTransformRule;
    // if there is no group caught there is no need to transform
    if (transformRule == null || match.groupCount == 0) {
      return ExtractionResult(
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
    return ExtractionResult(
      phoneNumber: transformed,
      prefix: nationalNumber.substring(0, match.end),
    );
  }
}
