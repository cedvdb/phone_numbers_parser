import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/constants.dart';

import 'models/country_phone_description.dart';

/// responsible of validating phone numbers
class Validator {
  /// Returns whether or not a national number is viable
  ///
  /// [nationalNumber] national number without country code,
  /// international prefix, or national prefix
  static bool isValidNationalNumber(
    String phoneNumber,
    CountryPhoneDescription desc,
  ) {
    if (phoneNumber.length < Constants.MIN_LENGTH_FOR_NSN) {
      return false;
    }
    final pattern = desc.validation.general.pattern;
    return RegExp(pattern).hasMatch('^$pattern\$');
  }
}
