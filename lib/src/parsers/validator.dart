import 'package:phone_numbers_parser/src/constants.dart';

import '../models/country_phone_description.dart';
import '../regexp_fix.dart';

/// responsible of validating phone numbers
class Validator {
  /// Returns whether or not a national number is viable
  ///
  /// [nsn] national number without country code,
  /// international prefix, or national prefix
  static bool isValidNationalNumber(
    String nationalNumber,
    CountryPhoneDescription desc,
  ) {
    if (nationalNumber.length < Constants.MIN_LENGTH_FOR_NSN) {
      return false;
    }
    final pattern = desc.validation.general.pattern;
    return RegExp(pattern).matchEntirely(nationalNumber) != null;
  }

  static bool isValidForType(
    PhoneNumberType? type,
    String nationalNumber,
    CountryPhoneDescription desc,
  ) {
    PhoneValidationRules rules;
    switch (type) {
      case PhoneNumberType.mobile:
        rules = desc.validation.mobile;
        break;
      case PhoneNumberType.fixedLine:
        rules = desc.validation.fixedLine;
        break;
      default:
        rules = desc.validation.general;
    }
    final isRightLength = rules.lengths.contains(nationalNumber.length);
    // if we don't have length information we will do pattern matching
    // or if the length is correct we do pattern matching too
    if (rules.lengths.isNotEmpty && !isRightLength) {
      return false;
    }
    return RegExp(rules.pattern).matchEntirely(nationalNumber) != null;
  }
}
