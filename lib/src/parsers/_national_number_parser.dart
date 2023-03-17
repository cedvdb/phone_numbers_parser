import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_regexp_manager.dart';

abstract class NationalNumberParser {
  /// extract the national prefix from the phone number if there is one
  /// this method assumes that the national number is in its international
  /// form with a national prefix in front. It does not transform the national
  /// number (except for removing the national prefix). See [transformLocalNsnToInternationalUsingPatterns].
  static String removeNationalPrefix(
    String nationalNumber,
    PhoneMetadata metadata,
  ) {
    final patterns =
        MetadataFinder.getMetadataPatternsForIsoCode(metadata.isoCode);

    final nationalPrefix = metadata.nationalPrefix;
    final leadingDigits = patterns.nationalPrefixTransformRule
      ?..replaceAll(r'$1', '')
      ..replaceAll(r'$2', '');

    if (nationalPrefix == null && metadata.leadingDigits == null) {
      return nationalNumber;
    }

    if (nationalPrefix != null && nationalNumber.startsWith(nationalPrefix)) {
      nationalNumber = nationalNumber.substring(nationalPrefix.length);
    }

    if (leadingDigits != null && nationalNumber.startsWith(leadingDigits)) {
      final match = RegExp(leadingDigits).firstMatch(nationalNumber);

      if (match != null) {
        nationalNumber = nationalNumber.substring(match.group(0)!.length);
      }
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
