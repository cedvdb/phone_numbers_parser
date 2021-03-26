import 'package:phone_numbers_parser/src/exceptions.dart';

import 'constants.dart';
import 'phone_number.dart';

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
class PhoneNumberParser implements PhoneNumberParserPublicAPI {
  /// Maximum length of input to prevents malicious input from overflowing the regexp engine.
  int maxInputLength = 250;

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

  @override
  PhoneNumber parse(
    String phoneNumber, {
    String? defaultIsoCode,
    String? defaultCountryCode,
  }) {
    phoneNumber = normalize(phoneNumber);

    // 1. get the region
    // 2. validate for region

    // 1. no params
    // - check if the number starts with +
    // - check if the number starts with 00 or 011
    // find first match
    // 2. iso code
    //
    // 3. dial code
  }

  /// Keeps only digits, plus char '+' and change easthern arabic numbers into westhern arabic numbers
  String _toPlusAndDigitsOnly(String string) {
    return string
        .split('')
        .map((char) => Patterns.allNormalizationMappings[char] ?? '')
        .join('');
  }
}
