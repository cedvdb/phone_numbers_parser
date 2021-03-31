import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/constants.dart';

import 'models/phone_description.dart';

class Validator {
  /// returns whether or not a national number is viable
  ///
  /// [nationalNumber] national number without country code,
  /// international prefix, or national prefix
  static bool isValidNationalNumber(
    String phoneNumber,
    CountryPhoneDescription desc,
  ) {
    if (phoneNumber.length < Patterns.MIN_LENGTH_FOR_NSN) {
      throw PhoneNumberException(code: Code.INVALID, description: 'too short');
    }
    final pattern = desc.validation.general.pattern;
    return RegExp(pattern).hasMatch('^$pattern\$');
  }
}
