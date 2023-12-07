import '../parsers/_validator.dart';
import 'generated/country_code_to_iso_code.dart';
import 'generated/metadata_by_iso_code.dart';
import 'generated/metadata_formats_by_iso_code.dart';
import 'generated/metadata_lengths_by_iso_code.dart';
import 'generated/metadata_patterns_by_iso_code.dart';
import 'models/phone_metadata.dart';
import 'models/phone_metadata_formats.dart';
import 'models/phone_metadata_lengths.dart';
import 'models/phone_metadata_patterns.dart';
import '../models/iso_code.dart';
import '../models/phone_number_exceptions.dart';

/// Helper to find metadata
abstract class MetadataFinder {
  /// expects a normalized iso code
  static PhoneMetadata getMetadataForIsoCode(IsoCode isoCode) {
    final metadata = metadataByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.invalidIsoCode,
        description: '$isoCode not found',
      );
    }
    return metadata;
  }

  /// expects a normalized iso code
  static PhoneMetadataPatterns getMetadataPatternsForIsoCode(IsoCode isoCode) {
    final metadata = metadataPatternsByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.invalidIsoCode,
        description: '$isoCode not found',
      );
    }
    return metadata;
  }

  static PhoneMetadataLengths getMetadataLengthForIsoCode(IsoCode isoCode) {
    final metadata = metadataLenghtsByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.invalidIsoCode,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  static PhoneMetadataFormats getMetadataFormatsForIsoCode(IsoCode isoCode) {
    final metadata = metadataFormatsByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.invalidIsoCode,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  /// expects normalized countryCode
  static PhoneMetadata getMetadatasForCountryCode(String countryCode) {
    final isoList = _getIsoCodesFromCountryCode(countryCode);
    final metadata = isoList.map((iso) => getMetadataForIsoCode(iso)).toList();
  }

  static List<IsoCode> _getIsoCodesFromCountryCode(String countryCode) {
    final isoCodes = countryCodeToIsoCode[countryCode];
    if (isoCodes == null) {
      throw PhoneNumberException(
        code: Code.invalidCountryCallingCode,
        description: 'countryCode $countryCode not found',
      );
    }
    return isoCodes;
  }

  static PhoneMetadata _getMatchUsingPatterns(
    String nationalNumber,
    List<PhoneMetadata> potentialFits,
  ) {
    if (potentialFits.length == 1) return potentialFits[0];
    potentialFits =
        _reducePotentialMetadatasFits(nationalNumber, potentialFits);
    for (var fit in potentialFits) {
      final isValidForIso =
          Validator.validateWithPattern(fit.isoCode, nationalNumber);
      if (isValidForIso) {
        return fit;
      }
    }
    return potentialFits[0];
  }

  /// Given a list of metadata fits, return the ones that fit a national number
  ///
  /// Expects a normalized [nationalNumber] that is in its international form
  static List<PhoneMetadata> _reducePotentialMetadatasFits(
    String nationalNumber,
    List<PhoneMetadata> potentialFits,
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
