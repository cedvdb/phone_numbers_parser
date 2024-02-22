import 'package:phone_numbers_parser/src/metadata/generated/metadata_lengths_by_iso_code.dart';
import 'package:phone_numbers_parser/src/models/iso_code.dart';
import 'package:phone_numbers_parser/src/models/phone_number_type.dart';

class MinMaxUtils {
  static MinMaxLength getMaxMinLengthByIsoCode(
      IsoCode isoCode, PhoneNumberType phoneNumberType) {
    final metadataLenghts = metadataLenghtsByIsoCode[isoCode];

    if (metadataLenghts == null) {
      // metadataLenghts should never be null, but if it's the case, we need to
      // throw an exception.
      throw MetadataLengthNotFoundException(isoCode);
    }

    if (phoneNumberType == PhoneNumberType.mobile) {
      final data = metadataLenghts.mobile;
      if (data.isNotEmpty) {
        return MinMaxLength(data.first, data.last);
      }
    } else if (phoneNumberType == PhoneNumberType.fixedLine) {
      final data = metadataLenghts.fixedLine;
      if (data.isNotEmpty) {
        return MinMaxLength(data.first, data.last);
      }
    } else if (phoneNumberType == PhoneNumberType.voip) {
      final data = metadataLenghts.voip;
      if (data.isNotEmpty) {
        return MinMaxLength(data.first, data.last);
      }
    }
    return MinMaxLength(15, 15);
  }
}

class MinMaxLength {
  int maxLength;
  int minLength;
  MinMaxLength(this.minLength, this.maxLength);
}

class MetadataLengthNotFoundException implements Exception {
  const MetadataLengthNotFoundException(this.isoCode);

  final IsoCode isoCode;

  @override
  String toString() {
    return 'No metadata length found for $isoCode';
  }
}
