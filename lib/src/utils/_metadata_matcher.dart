import 'package:phone_number_metadata/phone_number_metadata.dart' as p;
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/parsers/_validator.dart';

abstract class MetadataMatcher {
  static p.PhoneMetadata getMatchUsingPatterns(
    String nationalNumber,
    List<p.PhoneMetadata> potentialFits,
  ) {
    if (potentialFits.length == 1) return potentialFits[0];
    potentialFits = reducePotentialMetadatasFits(nationalNumber, potentialFits);
    for (var fit in potentialFits) {
      final isValidForIso = Validator.validateWithPattern(
          PhoneNumber(nsn: nationalNumber, isoCode: fit.isoCode));
      if (isValidForIso) {
        return fit;
      }
    }
    return potentialFits[0];
  }

  /// Given a list of metadata fits, return the ones that fit a national number
  ///
  /// Expects a normalized [nationalNumber] that is in its international form
  static List<p.PhoneMetadata> reducePotentialMetadatasFits(
    String nationalNumber,
    List<p.PhoneMetadata> potentialFits,
  ) {
    if (potentialFits.length == 1) {
      return potentialFits;
    }

    for (var fit in potentialFits) {
      // if multiple fits, check leading digits to see if there is a fit
      final leadingDigits = fit.leadingDigits;

      if (leadingDigits != null && nationalNumber.startsWith(leadingDigits)) {
        return [fit];
      }
    }

    return potentialFits;
  }
}
