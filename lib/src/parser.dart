import 'package:phone_numbers_parser/src/exceptions.dart';
import 'package:phone_numbers_parser/src/models/phone_description.dart';
import 'package:phone_numbers_parser/src/validator.dart';

import 'constants.dart';
import 'models/country.dart';
import 'phone_number.dart';

///
/// The terminology used throughout the parameters and the variable names:
///

abstract class PhoneNumberParserPublicAPI {
  /// Extracts phone numbers from string
  ///
  /// This can be useful for finding matches in a message, for display.
  ///
  /// The returned iterable lazily finds non-overlapping matches of possible phone numbers.
  /// If a user only requests the first match, this function should not compute all possible matches.
  /// The [string] parameter can be a any string with length lower than the [maxInputLength].
  ///
  /// Throws [PhoneNumberException] with code [Code.INPUT_IS_TOO_LONG]
  Iterable<Match> extractPotentialPhoneNumbers(String string);

  /// Normalize phone number so it's only digits and possible + sign
  ///
  /// Example:
  ///
  /// [unformatedPhoneNumber]: (+32) 0489/99.99.99
  /// Returns: +320489999999
  String normalize(String unformatedPhoneNumber);

  /// Parses a phone number strig into a PhoneNumber
  ///
  /// Throws [PhoneNumberException]
  PhoneNumber parse(
    String phoneNumber, {
    String? defaultIsoCode,
    String? defaultCountryCode,
  });
}

/// Parser helper to do various operations on Strings representing phone numbers
///
/// The terminology used throughout the parameters and the variable names:
///
/// {@macro string}
///
/// {@macro rawPhoneNumber}
/// {@macro normalizedPhoneNumber}
/// {@macro phoneNumber}
/// {@macro internationalPrefix}
/// {@macro dialCode}
/// {@macro nationalPrefix}
/// {@macro nationalNumber}
class PhoneNumberParser implements PhoneNumberParserPublicAPI {
  /// Maximum length of input to prevents malicious input from overflowing the regexp engine.
  int maxInputLength = 250;

  /// {@macro string}
  @override
  Iterable<Match> extractPotentialPhoneNumbers(String string) {
    if (string.length > maxInputLength) {
      throw PhoneNumberException(code: Code.INPUT_IS_TOO_LONG);
    }
    return RegExp(Patterns.POSSIBLE_PHONE_NUMBER).allMatches(string);
  }

  @override
  String normalize(String phoneNumber) {
    final firstMatch = extractPotentialPhoneNumbers(phoneNumber).first.group(0);
    if (firstMatch == null) throw PhoneNumberException(code: Code.NOT_FOUND);

    return _toPlusAndDigitsOnly(firstMatch);
  }

  /// Strips the international prefix of a phone number if present.
  ///
  /// This method expects a [normalizedPhoneNumber] that is already normalized.
  ///
  ///  - if [normalizedPhoneNumber] starts with + returns a List of one element [normalizedPhoneNumber]
  ///  - else if a default country is given
  ///    - if match strip and return [phoneNumber, prefix]
  ///  - if starts with 00 or 011 strip
  ///  - if no default country => not a valid phone number
  List<String> stripInternationalPrefix(
    String normalizedPhoneNumber,
    Country? defaultCountry,
  ) {
    // todo add check here if it's part of the public API
    if (normalizedPhoneNumber.startsWith('+')) {
      return [normalizedPhoneNumber];
    }
    // extract to fn
    if (defaultCountry != null) {
      final match = RegExp(defaultCountry.phone.internationalPrefix)
          .matchAsPrefix(normalizedPhoneNumber);
      if (match != null) {
        final prefix = normalizedPhoneNumber.substring(0, match.end);

        if (normalizedPhoneNumber.length == prefix.length) {
          throw PhoneNumberException(code: Code.INVALID);
        }
        final phoneNumberStriped =
            normalizedPhoneNumber.substring(match.end + 1);
        // check viability
        if (Validator.isNationalNumber(nationalNumber, defaultCountry.phone)) {
          return [nationalNumber, prefix];
        }
      }
    }
    throw PhoneNumberException(code: Code.INVALID);
  }

  // @override
  // PhoneNumber parse(
  //   String phoneNumber, {
  //   String? defaultIsoCode,
  //   String? defaultCountryCode,
  // }) {
  //   phoneNumber = normalize(phoneNumber);

  //   // 1. get the region
  //   // 2. validate for region

  //   // 1. no params
  //   // - check if the number starts with +
  //   // - check if the number starts with 00 or 011
  //   // find first match
  //   // 2. iso code
  //   //
  //   // 3. dial code
  // }

  /// Keeps only digits, plus char '+' and change easthern arabic numbers into westhern arabic numbers
  String _toPlusAndDigitsOnly(String string) {
    return string
        .split('')
        .map((char) => Patterns.allNormalizationMappings[char] ?? '')
        .join('');
  }

  stripInternationalPrefix() {}
}
