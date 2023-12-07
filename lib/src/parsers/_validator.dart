import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:phone_numbers_parser/src/models/iso_code.dart';
import 'package:phone_numbers_parser/src/regex/match_entirely_extension.dart';

import '../constants/constants.dart';
import '../metadata/models/phone_metadata_lengths.dart';
import '../metadata/models/phone_metadata_patterns.dart';
import '../models/phone_number_type.dart';

/// Validates phone numbers
abstract class Validator {
  /// Returns whether or not a national number is viable using pattern matching
  ///
  /// [nsn] national number without country code,
  /// international prefix, or national prefix
  static bool validateWithPattern(
    IsoCode isoCode,
    String national, [
    PhoneNumberType? type,
  ]) {
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    final patternMetadatas =
        MetadataFinder.getMetadataPatternsForIsoCode(metadata.isoCode);
    // if it's not matching the length it won't match the pattern
    if (!validateWithLength(isoCode, national)) {
      return false;
    }
    final patterns = <String>[];
    // if no type is specified we check both mobile and fixed line as checking the
    // general one gives too much false positives
    if (type == null) {
      patterns.addAll([
        _getPatterns(patternMetadatas, PhoneNumberType.fixedLine),
        _getPatterns(patternMetadatas, PhoneNumberType.mobile)
      ]);
    } else {
      patterns.add(_getPatterns(patternMetadatas, type));
    }
    return patterns.any((r) => r.matchEntirely(national) != null);
  }

  /// Returns whether or not a national number is viable using length
  ///
  /// [nsn] national number without country code,
  /// international prefix, or national prefix
  static bool validateWithLength(
    IsoCode isoCode,
    String national, [
    PhoneNumberType? type,
  ]) {
    final lengthMetadatas = MetadataFinder.getMetadataLengthForIsoCode(isoCode);
    if (national.length < Constants.minLengthNsn) {
      return false;
    }
    final lengths = _getPossibleLengths(lengthMetadatas, type);
    final isRightLength = lengths.contains(national.length);
    // if we don't have length information we will do pattern matching
    // or if the length is correct we do pattern matching too
    if (isRightLength) {
      return true;
    }
    return false;
  }

  static Set<int> _getPossibleLengths(
    PhoneMetadataLengths lengthMetadatas,
    PhoneNumberType? type,
  ) {
    if (type != null) {
      final lengths = _getLengths(lengthMetadatas, type);
      return Set.from(lengths);
    } else {
      // if the type is not specified it can be either mobile or fixedLine
      // so we return a set containing both
      final rulesFixed =
          _getLengths(lengthMetadatas, PhoneNumberType.fixedLine);
      final rulesMobile = _getLengths(lengthMetadatas, PhoneNumberType.mobile);
      return {...rulesFixed, ...rulesMobile};
    }
  }

  static List<int> _getLengths(
    PhoneMetadataLengths lengthMetadatas,
    PhoneNumberType? type,
  ) {
    switch (type) {
      case PhoneNumberType.mobile:
        return lengthMetadatas.mobile;
      case PhoneNumberType.fixedLine:
        return lengthMetadatas.fixedLine;
      default:
        return lengthMetadatas.general;
    }
  }

  static String _getPatterns(
    PhoneMetadataPatterns patternMetadatas,
    PhoneNumberType? type,
  ) {
    switch (type) {
      case PhoneNumberType.mobile:
        return patternMetadatas.mobile;
      case PhoneNumberType.fixedLine:
        return patternMetadatas.fixedLine;
      default:
        return patternMetadatas.general;
    }
  }
}
