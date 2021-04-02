import 'package:phone_numbers_parser/src/exceptions.dart';
import 'package:phone_numbers_parser/src/validator.dart';

import '../constants.dart';
import '../models/country.dart';
import '../phone_number.dart';
import 'prefix_parser.dart';

/// The terminology used throughout the parameters and the variable names:
///
/// {@template text}
/// [text] text that might contain a phone number.
/// It could be an email, chat message, etc.
/// {@endtemplate}
///
/// {@template rawPhoneNumber}
/// [rawPhoneNumber] is a phone number that might contain punctuation.
/// {@endtemplate}
///
/// {@template normalizedPhoneNumber}
/// [normalizedPhoneNumber] is a phone number that contains only digits and
/// potentially a leading +.
/// {@endtemplate}
///
/// {@template phoneNumberDigitsOnly}
/// [phoneNumberDigitsOnly] a [normalizedPhoneNumber] with the leading + removed
/// {@endtemplate}
///
/// {@template phoneNumber}
/// [phoneNumber] is a phone number starting with the country code, without +
/// and without [internationalPrefix].
/// {@endtemplate}
///
/// /// {@template nationalNumber}
/// [nationalNumber] is the phone number without [nationalPrefix], [dialCode]
/// and [internationalPrefix].
/// {@endtemplate}
///
/// {@template internationalPrefix}
/// [internationalPrefix] is the leading digits that replace the + when
/// calling a country. Most often 00 or 011.
/// {@endtemplate}
///
/// {@template dialCode}
/// [dialCode] is the country digits, example france it's 33
/// {@endtemplate}
///
/// {@template nationalPrefix}
/// [nationalPrefix] are the digits to call a phone number nationally,
/// most often 0.
/// {@endtemplate}
///

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

  PhoneNumber parse(
    String rawPhoneNumber, {
    String? defaultIsoCode,
    String? defaultCountryCode,
  });
}

/// Parser helper to do various operations on Strings representing phone numbers
class PhoneNumberParser {
  /// Maximum length of input to prevents malicious input from overflowing the regexp engine.
  int maxInputLength = 250;

  /// {@macro text}
  Iterable<Match> extractPotentialPhoneNumbers(String text) {
    if (text.length > maxInputLength) {
      throw PhoneNumberException(code: Code.INPUT_IS_TOO_LONG);
    }
    return RegExp(Patterns.POSSIBLE_PHONE_NUMBER).allMatches(text);
  }

  /// {@macro rawPhoneNumber}
  String _normalize(String rawPhoneNumber) {
    final firstMatch =
        extractPotentialPhoneNumbers(rawPhoneNumber).first.group(0);
    if (firstMatch == null) {
      throw PhoneNumberException(code: Code.NOT_FOUND);
    }

    return _toPlusAndDigitsOnly(firstMatch);
  }

  PhoneNumber parse(
    String rawPhoneNumber,
  ) {}

  /// Strips the international prefix of a phone number if present.
  ///
  /// {@macro normalizedPhoneNumber}
  /// The returned list contains the [phoneNumber] and the [internationalPrefix].
  /// The first element is always the [phoneNumber], the
  /// second element, if any, is the [internationalPrefix]
  ///  - if [normalizedPhoneNumber] starts with +
  ///    returns a List of one element [phoneNumber]
  ///  - else if a [defaultCountry] is given
  ///    - returns [phoneNumber, internationalPrefix]
  ///  - else if starts with 00 or 011
  ///    we consider those as internationalPrefix and return [phoneNumber, internationalPrefix]
  ///
  /// Throws not [PhoneNumberException]
  List<String> _extractInternationalPrefix(
    ModifiablePhoneNumber normalizedPhoneNumber,
    Country? defaultCountry,
  ) {
    return PrefixParser.extractInternationalPrefix(
      normalizedPhoneNumber,
      defaultCountry,
    );
  }

  // the country dial code cannot start with 0
  void _checkValidDialCodeStart(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      throw PhoneNumberException(
        code: Code.INVALID,
        description: 'The country code cannot start with 0',
      );
    }
  }

  /// Keeps only digits, plus char '+' and change easthern arabic numbers into westhern arabic numbers
  String _toPlusAndDigitsOnly(String string) {
    return string
        .split('')
        .map((char) => Patterns.allNormalizationMappings[char] ?? '')
        .join('');
  }
}
