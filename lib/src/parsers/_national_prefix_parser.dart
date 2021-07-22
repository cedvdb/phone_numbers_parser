import 'package:phone_number_metadata/phone_number_metadata.dart';

abstract class NationalPrefixParser {
  /// extract the national prefix from the phone number if there is one
  /// this method assumes that the national number is in its international
  /// form with a national prefix in front. It does not transform the national
  /// number (except for removing the national prefix). See [transformLocalNsnToInternational].
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
  //  number as +54 9 343 555 1212 (international)
  static String transformLocalNsnToInternational(
    String nationalNumber,
    PhoneMetadataExtended metadata,
  ) {
    final nationalPrefixForParsing = metadata.nationalPrefixForParsing;
    final transformRule = metadata.nationalPrefixTransformRule;

    if (nationalPrefixForParsing != null) {
      final transformed = _applyTransformRules(
        nationalNumber,
        nationalPrefixForParsing,
        transformRule,
      );
      return transformed;
    } else {
      return removeNationalPrefix(nationalNumber, metadata);
    }
  }

  static String _applyTransformRules(
    String nationalNumber,
    String nationalPrefixForParsing,
    String? transformRule,
  ) {
    // match as prefix because we are only replacing the group and keeping
    // the end intact
    final match =
        RegExp(nationalPrefixForParsing).matchAsPrefix(nationalNumber);
    if (match == null) {
      return nationalNumber;
    }
    // if there is no group caught there is no need to transform
    // it is possible for a group to be null despite the group count being 1
    if (transformRule == null ||
        match.groupCount == 0 ||
        match.group(1) == null) {
      return nationalNumber.substring(match.end);
    }

    var transformed = transformRule;
    final shouldContinueLoop = (int i) =>
        match.groupCount >= i &&
        match.group(i) != null &&
        transformed.contains('\$$i');
    for (var i = 1; shouldContinueLoop(i); i++) {
      transformed = transformed.replaceFirst('\$$i', match.group(i)!);
    }
    return transformed + nationalNumber.substring(match.end);
  }
}
