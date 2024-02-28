import '../regex/constants.dart';

/// responsible of normalizing and finding phone numbers in text
abstract class TextParser {
  /// Normalize phone number so it's only digits and possible + sign.
  ///
  /// It also converts easthern arabic digits to westhern arabic.
  ///
  /// Example:
  /// [unformatedPhoneNumber]: (+32) 0489/99.99.99
  /// Returns: +320489999999
  static String normalizePhoneNumber(String unformatedPhoneNumber) {
    return unformatedPhoneNumber
        .split('')
        .map((char) => Constants.allNormalizationMappings[char] ?? '')
        .join('');
  }

  /// Extracts phone numbers from a [text].
  /// The potential phone numbers returned are not checked for their validity.
  /// It is possible that a match could be a date or anything else ressembling a phone number.
  /// To verify it is in fact a phone number you can parse it and check its validity
  static Iterable<Match> findPotentialPhoneNumbers(String text) {
    return RegExp(Constants.possiblePhoneNumber).allMatches(text);
  }
}
