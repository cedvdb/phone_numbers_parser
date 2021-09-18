import 'package:phone_number_metadata/phone_number_metadata.dart' as p;
import '../models/phone_number_exceptions.dart';

abstract class MetadataFinder {
  /// expects a normalized iso code
  static p.PhoneMetadata getMetadataForIsoCode(String isoCode) {
    final metadata = p.metadataByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.INVALID_ISO_CODE,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  /// expects a normalized iso code
  static p.PhoneMetadataPatterns getMetadataPatternsForIsoCode(String isoCode) {
    final metadata = p.metadataPatternsByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.INVALID_ISO_CODE,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  static p.PhoneMetadataLengths getMetadataLengthForIsoCode(String isoCode) {
    final metadata = p.metadataLenghtsByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.INVALID_ISO_CODE,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  /// expects normalized countryCode
  static List<p.PhoneMetadata> getMetadatasForCountryCode(String countryCode) {
    final isoList = _getIsoCodesFromCountryCode(countryCode);
    return isoList.map((iso) => getMetadataForIsoCode(iso)).toList();
  }

  static List<String> _getIsoCodesFromCountryCode(String countryCode) {
    final isoCodes = p.countryCodeToIsoCode[countryCode];
    if (isoCodes == null) {
      throw PhoneNumberException(
        code: Code.INVALID_COUNTRY_CALLING_CODE,
        description: 'countryCode $countryCode not found',
      );
    }
    return isoCodes;
  }
}
