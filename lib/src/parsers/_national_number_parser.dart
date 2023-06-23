import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:phone_numbers_parser/src/regex/regexp_manager.dart';

import '../metadata/models/phone_metadata.dart';

abstract class NationalNumberParser {
  /// extract the national prefix from the phone number if there is one
  /// this method assumes that the national number is in its international
  /// form with a national prefix in front. It does not transform the national
  /// number (except for removing the national prefix). See [transformLocalNsnToInternationalUsingPatterns].
  static String removeNationalPrefix(
    String nationalNumber,
    PhoneMetadata metadata,
  ) {
    final nationalPrefix = metadata.nationalPrefix;
    if (nationalPrefix == null) return nationalNumber;
    if (nationalNumber.startsWith(nationalPrefix)) {
      return nationalNumber.substring(nationalPrefix.length);
    }
    return nationalNumber;
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
        MetadataFinder.getMetadataPatternsForIsoCode(metadata.isoCode);
    final nationalPrefixForParsing = patterns.nationalPrefixForParsing;
    final transformRule = patterns.nationalPrefixTransformRule;

    if (nationalPrefixForParsing != null) {
      final transformed = RegexpManager.applyTransformRules(
        appliedTo: nationalNumber,
        pattern: nationalPrefixForParsing,
        transformRule: transformRule,
      );
      return transformed;
    } else {
      return removeNationalPrefix(nationalNumber, metadata);
    }
  }
}
