import 'package:phone_number_metadata/phone_number_metadata.dart';

import '../constants/constants.dart';
import '../utils/_regexp_ext.dart';
import '../models/phone_number_type.dart';

/// Validates phone numbers
abstract class Validator {
  /// Returns whether or not a national number is viable using pattern matching
  ///
  /// [nsn] national number without country code,
  /// international prefix, or national prefix
  static bool validateWithPattern(
    String nsn,
    PhoneMetadataExtended metadata, [
    PhoneNumberType? type,
  ]) {
    // if it's not matching the length it won't match the pattern
    if (!validateWithLength(nsn, metadata)) {
      return false;
    }
    final rules = [];
    // if no type is specified we check both mobile and fixed line as checking the
    // general one gives too much false positives
    if (type == null) {
      rules.addAll([
        _getRules(metadata, PhoneNumberType.fixedLine)
            as PhoneValidationRulesExtended,
        _getRules(metadata, PhoneNumberType.mobile)
            as PhoneValidationRulesExtended
      ]);
    } else {
      rules.add(_getRules(metadata, type));
    }
    return rules.any((r) => RegExp(r.pattern).matchEntirely(nsn) != null);
  }

  /// Returns whether or not a national number is viable using length
  ///
  /// [nsn] national number without country code,
  /// international prefix, or national prefix
  static bool validateWithLength(
    String nsn,
    PhoneMetadata metadata, [
    PhoneNumberType? type,
  ]) {
    if (nsn.length < Constants.MIN_LENGTH_FOR_NSN) {
      return false;
    }
    final lengths = _getPossibleLengths(metadata, type);
    final isRightLength = lengths.contains(nsn.length);
    // if we don't have length information we will do pattern matching
    // or if the length is correct we do pattern matching too
    if (isRightLength) {
      return true;
    }
    return false;
  }

  static Set<int> _getPossibleLengths(
    PhoneMetadata metadata,
    PhoneNumberType? type,
  ) {
    if (type != null) {
      final rules = _getRules(metadata, type);
      return Set.from(rules.lengths);
    } else {
      // if the type is not specified it can be either mobile or fixedLine
      final rulesFixed = _getRules(metadata, PhoneNumberType.fixedLine);
      final rulesMobile = _getRules(metadata, PhoneNumberType.mobile);
      return {...rulesFixed.lengths, ...rulesMobile.lengths};
    }
  }

  static PhoneValidationRules _getRules(
      PhoneMetadata metadata, PhoneNumberType? type) {
    switch (type) {
      case PhoneNumberType.mobile:
        return metadata.validation.mobile;
      case PhoneNumberType.fixedLine:
        return metadata.validation.fixedLine;
      default:
        return metadata.validation.general;
    }
  }
}
