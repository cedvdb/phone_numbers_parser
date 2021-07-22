import 'package:phone_number_metadata/phone_number_metadata.dart' as p;
import '../models/phone_number_exceptions.dart';

abstract class MetadataFinder {
  /// expects a nomalized iso code
  static p.PhoneMetadataExtended getExtendedMetadataForIsoCode(String isoCode) {
    final metadata = p.extendedMetadataByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.INVALID_ISO_CODE,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  /// expects a normalized iso code
  static p.PhoneMetadata getLightMetadataForIsoCode(String isoCode) {
    final metadata = p.lightMetadataByIsoCode[isoCode];
    if (metadata == null) {
      throw PhoneNumberException(
        code: Code.INVALID_ISO_CODE,
        description: 'isoCode "$isoCode" not found',
      );
    }
    return metadata;
  }

  /// expects normalized dialCode
  static List<p.PhoneMetadata> getLightMetadatasForDialCode(String dialCode) {
    final isoList = _getIsoCodesFromDialCode(dialCode);
    return isoList.map((iso) => getLightMetadataForIsoCode(iso)).toList();
  }

  /// expects normalized dialCode
  static List<p.PhoneMetadataExtended> getExtendedMetadatasForDialCode(
      String dialCode) {
    final isoList = _getIsoCodesFromDialCode(dialCode);
    return isoList.map((iso) => getExtendedMetadataForIsoCode(iso)).toList();
  }

  static List<String> _getIsoCodesFromDialCode(String dialCode) {
    final isoCodes = p.dialCodeToIsoCode[dialCode];
    if (isoCodes == null) {
      throw PhoneNumberException(
        code: Code.INVALID_DIAL_CODE,
        description: 'dialCode $dialCode not found',
      );
    }
    return isoCodes;
  }
}
