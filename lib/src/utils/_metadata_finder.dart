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

  /// expects normalized countryCallingCode
  static List<p.PhoneMetadata> getMetadatasForCountryCallingCode(
      String countryCallingCode) {
    final isoList = _getIsoCodesFromCountryCallingCode(countryCallingCode);
    return isoList.map((iso) => getMetadataForIsoCode(iso)).toList();
  }

  static List<String> _getIsoCodesFromCountryCallingCode(
      String countryCallingCode) {
    final isoCodes = p.countryCallingCodeToIsoCode[countryCallingCode];
    if (isoCodes == null) {
      throw PhoneNumberException(
        code: Code.INVALID_COUNTRY_CALLING_CODE,
        description: 'countryCallingCode $countryCallingCode not found',
      );
    }
    return isoCodes;
  }
}
