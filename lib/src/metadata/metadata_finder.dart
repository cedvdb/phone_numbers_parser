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
  static List<PhoneMetadata> getMetadatasForCountryCode(String countryCode) {
    final isoList = _getIsoCodesFromCountryCode(countryCode);
    return isoList.map((iso) => getMetadataForIsoCode(iso)).toList();
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
}
