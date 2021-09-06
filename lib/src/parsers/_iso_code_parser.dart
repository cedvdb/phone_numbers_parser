import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';

abstract class IsoCodeParser {
  /// normalize an iso code to be what the lib expects, mainly uppercases it
  static String normalizeIsoCode(String isoCode) {
    isoCode = isoCode.toUpperCase().trim();
    if (isoCode.length != 2) {
      throw PhoneNumberException(
          code: Code.INVALID_ISO_CODE,
          description: "incorrect length, found '$isoCode'");
    }
    return isoCode;
  }
}
