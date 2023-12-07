import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';

import '../metadata/models/phone_metadata.dart';

abstract class NationalNumberParser {
  /// extract the national prefix from the phone number if there is one
  /// this method assumes that the national number is in its international
  /// form with a national prefix in front. It does not transform the national
  /// number (except for removing the national prefix). See [transformLocalNsnToInternationalUsingPatterns].
  static (String nationalPrefix, String nsn) extractNationalPrefix(
    String nationalNumber,
    PhoneMetadata metadata,
  ) {
    final nationalPrefix = metadata.nationalPrefix;
    if (nationalPrefix == null) return ('', nationalNumber);
    if (nationalNumber.startsWith(nationalPrefix)) {
      return (
        nationalPrefix,
        nationalNumber.substring(nationalPrefix.length),
      );
    }
    return ('', nationalNumber);
  }

  /// extract the national prefix from the phone number and convert
  /// local to international nsn
  ///
  /// example: in argentina 0343 15 555 1212 (local) is exactly the
  ///  number as +54 9 343 555 1212 (international)
  ///
  /// note: uses pattern metadata
  static String transformLocalNsnToInternationalUsingPatterns(
    String nationalNumber,
    PhoneMetadata metadata,
  ) {
    final patterns =
        MetadataFinder.findMetadataPatternsForIsoCode(metadata.isoCode);
    final nationalPrefixForParsing = patterns.nationalPrefixForParsing;
    final transformRule = patterns.nationalPrefixTransformRule;

    if (nationalPrefixForParsing != null) {
      final transformed = applyTransformRules(
        appliedTo: nationalNumber,
        pattern: nationalPrefixForParsing,
        transformRule: transformRule,
      );
      return transformed;
    } else {
      final (_, nsn) = extractNationalPrefix(nationalNumber, metadata);
      return nsn;
    }
  }

  static String applyTransformRules({
    required String appliedTo,
    required String pattern,
    required String? transformRule,
  }) {
    // match as prefix because we are only replacing the group and keeping
    // the end intact
    final match = RegExp(pattern).matchAsPrefix(appliedTo);

    if (match == null) {
      return appliedTo;
    }
    // if there is no group caught there is no need to transform
    // it is possible for a group to be null despite the group count being 1
    if (transformRule == null ||
        match.groupCount == 0 ||
        match.group(1) == null) {
      return appliedTo.substring(match.end);
    }

    var transformed = transformRule;
    bool shouldContinueLoop(int i) =>
        match.groupCount >= i &&
        match.group(i) != null &&
        transformed.contains('\$$i');
    for (var i = 1; shouldContinueLoop(i); i++) {
      transformed = transformed.replaceFirst('\$$i', match.group(i)!);
    }
    return transformed + appliedTo.substring(match.end);
  }
}
