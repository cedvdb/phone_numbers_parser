import 'dart:math';

import 'package:phone_numbers_parser/src/constants.dart';
import 'package:phone_numbers_parser/src/generated/countries_by_dial_code_map.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/country_phone_description.dart';
import '../regexp_fix.dart';
import 'country_parser.dart';

class ExtractResult<T> {
  String phoneNumber;
  T? extracted;

  ExtractResult({
    required this.extracted,
    required this.phoneNumber,
  });
}

/// Responsible of extracting different parts of a phone number.
/// The philosophy of this class is to not throw error, and return null instead
/// where errors are thrown by the class using the [Extractor].
class Extractor {
  /// Extracts the country dial code from a [phoneNumber].
  ///
  /// It expects a normalized [phoneNumber] starting
  /// with the country code and without the +.
  static ExtractResult<String> extractDialCode(String phoneNumber) {
    var dialCode = '';
    // Country dial codes do not begin with a '0'.
    if (phoneNumber.isNotEmpty || !phoneNumber.startsWith('0')) {
      String potentialCountryCode;
      final numberLength = phoneNumber.length;
      final max = min(numberLength, Constants.MAX_LENGTH_COUNTRY_DIAL_CODE);
      for (var i = 1; i <= max; i++) {
        potentialCountryCode = phoneNumber.substring(0, i);
        if (countriesByDialCode.containsKey(potentialCountryCode)) {
          dialCode = potentialCountryCode;
          break;
        }
      }
    }
    return ExtractResult(
      phoneNumber: phoneNumber.substring(dialCode.length),
      extracted: dialCode,
    );
  }

  /// extract the international prefix of a phone number if present.
  ///
  /// It expects a normalized [phoneNumber].
  ///
  ///  - if [phoneNumber] starts with +, there is no prefix
  ///  - else if starts with 00 or 011
  ///    we consider those as internationalPrefix as
  ///    they cover 4/5 of the international prefix
  static ExtractResult<String> extractInternationalPrefix(
    String phoneNumber, [
    Country? country,
  ]) {
    if (phoneNumber.startsWith('+')) {
      return ExtractResult(
        // we remove the plus as to stay consistent with other results
        phoneNumber: phoneNumber.substring(1),
        extracted: null,
      );
    }

    if (country != null) {
      return _extractInternationalPrefixFromDefaultCountry(
        phoneNumber,
        country,
      );
    }
    // 4/5 of the world wide numbers start with 00 or 011
    if (phoneNumber.startsWith('00')) {
      return ExtractResult(
          phoneNumber: phoneNumber.substring(2), extracted: '00');
    }

    if (phoneNumber.startsWith('011')) {
      return ExtractResult(
          phoneNumber: phoneNumber.substring(3), extracted: '011');
    }

    return ExtractResult(phoneNumber: phoneNumber, extracted: null);
  }

  static ExtractResult<String> _extractInternationalPrefixFromDefaultCountry(
    String phoneNumber,
    Country country,
  ) {
    final match =
        RegExp(country.phone.internationalPrefix).matchAsPrefix(phoneNumber);
    if (match != null) {
      return ExtractResult(
        phoneNumber: phoneNumber.substring(match.end + 1),
        extracted: phoneNumber.substring(0, match.end),
      );
    }
    // if it does not start with the international prefix from the
    // country we assume the prefix is not present
    return ExtractResult(
      phoneNumber: phoneNumber,
      extracted: null,
    );
  }

  /// extract the national prefix of a [nationalNumber] and applies possible
  /// transformation to the nationalNumber which might be valid locally
  /// to make it a valid nationalNumber internationally
  static ExtractResult<String> extractNationalPrefix(
    String nationalNumber,
    Country country,
  ) {
    var nationalPrefix;
    final countryNationalPrefix = country.phone.nationalPrefix;

    if (countryNationalPrefix != null &&
        nationalNumber.startsWith(countryNationalPrefix)) {
      nationalPrefix = country.phone.nationalPrefix;
      nationalNumber = nationalNumber.substring(nationalPrefix.length);
    }

    nationalNumber =
        _transformLocalNsnToInternationalNsn(nationalNumber, country);

    return ExtractResult(
      phoneNumber: nationalNumber,
      // nationalPrefix will be null if it was not removed, even though
      // we have the country and could add it, to stay coherent with the
      // other methods in this class
      extracted: nationalPrefix,
    );
  }

  static String _transformLocalNsnToInternationalNsn(
    String nationalNumber,
    Country country,
  ) {
    final nationalPrefixForParsing = country.phone.nationalPrefixForParsing;
    if (nationalPrefixForParsing == null) {
      return nationalNumber;
    }
    final match =
        RegExp(nationalPrefixForParsing).matchAsPrefix(nationalNumber);
    if (match == null) {
      return nationalNumber;
    }
    final transformRule = country.phone.nationalPrefixTransformRule;
    // if there is no group caught there is no need to transform
    if (transformRule == null || match.groupCount == 0) {
      return nationalNumber;
    }
    // I did not find a built in way of replacing a match with a template so
    // let's do it by hand. There seems to be be max 2 groups. todo add loop instead
    var transformed = transformRule.replaceFirst(r'$1', match.group(1)!);
    if (match.groupCount > 1) {
      transformed = transformed.replaceFirst(r'$2', match.group(2)!);
    }
    return transformed;
  }

  /// Gets the country of a [nationalNumber] by providing a [dialCode]
  ///
  /// Since a [dialCode] can target multiple countries, this will use pattern
  /// matching to figuring out the correct one.
  /// the returned [ExtractResult] will contain the country if found, and the
  /// national number transformed for international use
  static ExtractResult<Country> extractCountry(
    String nationalNumber,
    String dialCode,
  ) {
    final potentialCountries = CountryParser.listFromDialCode(dialCode);

    if (potentialCountries.length == 1) {
      return ExtractResult(
        phoneNumber: _transformLocalNsnToInternationalNsn(
          nationalNumber,
          potentialCountries[0],
        ),
        extracted: potentialCountries[0],
      );
    }

    for (var country in potentialCountries) {
      // 3. check leading digits
      final nationalPrefix = country.phone.nationalPrefix;
      final leadingDigits = country.phone.leadingDigits;
      var parsedNationalNumber = nationalNumber;

      if (nationalPrefix != null &&
          nationalNumber.startsWith(RegExp(nationalPrefix))) {
        parsedNationalNumber = nationalNumber.substring(nationalPrefix.length);
      }
      final transformedNationalNumber = _transformLocalNsnToInternationalNsn(
        nationalNumber,
        country,
      );

      if (leadingDigits != null &&
          parsedNationalNumber.startsWith(leadingDigits)) {
        return ExtractResult(
          phoneNumber: transformedNationalNumber,
          extracted: country,
        );
      }
      // 4. attempt pattern matching against the different types
      // first we transform it so it fits the pattern
      if (getType(transformedNationalNumber, country) != null) {
        return ExtractResult(
          phoneNumber: transformedNationalNumber,
          extracted: country,
        );
      }
    }

    return ExtractResult(
      phoneNumber: nationalNumber,
      extracted: null,
    );
  }

  /// gets get [PhoneNumberType] of a phone number by checking
  /// if it matches any pattern in the list of mobile and fixedLine.
  ///
  /// [nationalPhoneNumber] a parsed national phone number without national prefix
  /// that has already been transformed
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
