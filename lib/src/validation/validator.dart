import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:phone_numbers_parser/src/iso_codes/iso_code.dart';
import 'package:phone_numbers_parser/src/regex/match_entirely_extension.dart';

import '../regex/constants.dart';
import '../metadata/models/phone_metadata_lengths.dart';
import '../metadata/models/phone_metadata_patterns.dart';
import 'phone_number_type.dart';

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
    final metadata = MetadataFinder.findMetadataForIsoCode(isoCode);
    final patternMetadatas =
        MetadataFinder.findMetadataPatternsForIsoCode(metadata.isoCode);
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
        _getPatterns(patternMetadatas, PhoneNumberType.mobile),
        if (patternMetadatas.voip.isNotEmpty)
          _getPatterns(patternMetadatas, PhoneNumberType.voip),
        if (patternMetadatas.tollFree.isNotEmpty)
          _getPatterns(patternMetadatas, PhoneNumberType.tollFree),
        if (patternMetadatas.premiumRate.isNotEmpty)
          _getPatterns(patternMetadatas, PhoneNumberType.premiumRate),
        if (patternMetadatas.sharedCost.isNotEmpty)
          _getPatterns(patternMetadatas, PhoneNumberType.sharedCost),
        if (patternMetadatas.personalNumber.isNotEmpty)
          _getPatterns(patternMetadatas, PhoneNumberType.personalNumber),
        if (patternMetadatas.uan.isNotEmpty)
          _getPatterns(patternMetadatas, PhoneNumberType.uan),
        if (patternMetadatas.pager.isNotEmpty)
          _getPatterns(patternMetadatas, PhoneNumberType.pager),
        if (patternMetadatas.voiceMail.isNotEmpty)
          _getPatterns(patternMetadatas, PhoneNumberType.voiceMail),
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
    final lengthMetadatas =
        MetadataFinder.findMetadataLengthForIsoCode(isoCode);
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
      // if the type is not specified it can be any of them
      // so we return a set containing all their possible lengths
      return {
        ..._getLengths(lengthMetadatas, PhoneNumberType.fixedLine),
        ..._getLengths(lengthMetadatas, PhoneNumberType.mobile),
        ..._getLengths(lengthMetadatas, PhoneNumberType.voip),
        ..._getLengths(lengthMetadatas, PhoneNumberType.tollFree),
        ..._getLengths(lengthMetadatas, PhoneNumberType.premiumRate),
        ..._getLengths(lengthMetadatas, PhoneNumberType.sharedCost),
        ..._getLengths(lengthMetadatas, PhoneNumberType.personalNumber),
        ..._getLengths(lengthMetadatas, PhoneNumberType.uan),
        ..._getLengths(lengthMetadatas, PhoneNumberType.pager),
        ..._getLengths(lengthMetadatas, PhoneNumberType.voiceMail),
      };
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
      case PhoneNumberType.voip:
        return lengthMetadatas.voip;
      case PhoneNumberType.tollFree:
        return lengthMetadatas.tollFree;
      case PhoneNumberType.premiumRate:
        return lengthMetadatas.premiumRate;
      case PhoneNumberType.sharedCost:
        return lengthMetadatas.sharedCost;
      case PhoneNumberType.personalNumber:
        return lengthMetadatas.personalNumber;
      case PhoneNumberType.uan:
        return lengthMetadatas.uan;
      case PhoneNumberType.pager:
        return lengthMetadatas.pager;
      case PhoneNumberType.voiceMail:
        return lengthMetadatas.voiceMail;
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
      case PhoneNumberType.voip:
        return patternMetadatas.voip;
      case PhoneNumberType.tollFree:
        return patternMetadatas.tollFree;
      case PhoneNumberType.premiumRate:
        return patternMetadatas.premiumRate;
      case PhoneNumberType.sharedCost:
        return patternMetadatas.sharedCost;
      case PhoneNumberType.personalNumber:
        return patternMetadatas.personalNumber;
      case PhoneNumberType.uan:
        return patternMetadatas.uan;
      case PhoneNumberType.pager:
        return patternMetadatas.pager;
      case PhoneNumberType.voiceMail:
        return patternMetadatas.voiceMail;
      default:
        return patternMetadatas.general;
    }
  }
}
