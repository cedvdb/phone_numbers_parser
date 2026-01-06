import '../validation/validator.dart';
import 'lazy_metadata_loader.dart';
import 'models/phone_metadata.dart';
import 'models/phone_metadata_formats.dart';
import 'models/phone_metadata_lengths.dart';
import 'models/phone_metadata_patterns.dart';
import '../iso_codes/iso_code.dart';
import '../parsers/phone_number_exceptions.dart';

/// Helper to find metadata using lazy loading for memory efficiency
abstract class MetadataFinder {
  static final _loader = LazyMetadataLoader.instance;

  /// expects a normalized iso code
  static PhoneMetadata findMetadataForIsoCode(IsoCode isoCode) {
    final metadata = _loader.getMetadata(isoCode);
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.invalidIsoCode,
        description: '$isoCode not found',
      );
    }
    return metadata;
  }

  /// expects a normalized iso code
  static PhoneMetadataPatterns findMetadataPatternsForIsoCode(IsoCode isoCode) {
    final metadata = _loader.getPatterns(isoCode);
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.invalidIsoCode,
        description: '$isoCode not found',
      );
    }
    return metadata;
  }

  static PhoneMetadataLengths findMetadataLengthForIsoCode(IsoCode isoCode) {
    final metadata = _loader.getLengths(isoCode);
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.invalidIsoCode,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  static PhoneMetadataFormats findMetadataFormatsForIsoCode(IsoCode isoCode) {
    final metadata = _loader.getFormats(isoCode);
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.invalidIsoCode,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  /// expects normalized countryCode
  static PhoneMetadata? findMetadataForCountryCode(
    String countryCode,
    String nationalNumber,
  ) {
    final isoList = _getIsoCodesFromCountryCode(countryCode);

    if (isoList.isEmpty) {
      return null;
    }
    // country code can have multiple metadata because multiple iso code
    // share the same country code.
    final allMatchingMetadata =
        isoList.map((iso) => findMetadataForIsoCode(iso)).toList();

    final match = _getMatchUsingPatterns(nationalNumber, allMatchingMetadata);
    return match;
  }

  static List<IsoCode> _getIsoCodesFromCountryCode(String countryCode) {
    return _loader.getIsoCodesFromCountryCode(countryCode);
  }

  static PhoneMetadata _getMatchUsingPatterns(
    String nationalNumber,
    List<PhoneMetadata> potentialFits,
  ) {
    if (potentialFits.length == 1) return potentialFits[0];
    // if the phone number is valid for a metadata return that metadata
    for (var fit in potentialFits) {
      final isValidForIso =
          Validator.validateWithPattern(fit.isoCode, nationalNumber);
      if (isValidForIso) {
        return fit;
      }
    }
    // otherwise the phone number starts with leading digits of metadata
    for (var fit in potentialFits) {
      final leadingDigits = fit.leadingDigits;
      if (leadingDigits != null && nationalNumber.startsWith(leadingDigits)) {
        return fit;
      }
    }

    // best guess here
    return potentialFits.firstWhere(
      (fit) => fit.isMainCountryForDialCode,
      orElse: () => potentialFits[0],
    );
  }
}
