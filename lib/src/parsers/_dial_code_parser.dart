import 'package:phone_number_metadata/phone_number_metadata.dart' as p;
import 'package:phone_number_parser/src/constants/constants.dart';
import 'package:phone_number_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_number_parser/src/parsers/_validator.dart';

import '_text_parser.dart';

abstract class DialCodeParser {
  /// normalize a dial code to return only digits
  static String normalizeDialCode(String dialCode) {
    dialCode = TextParser.normalize(dialCode);
    if (dialCode.startsWith('+')) {
      dialCode = dialCode.replaceFirst('+', '');
    }
    // dial code don't start with zero
    if (dialCode.startsWith('0')) {
      throw PhoneNumberException(
          code: Code.INVALID_DIAL_CODE,
          description: 'dial code do not start with 0');
    }
    if (dialCode.length < Constants.MIN_LENGTH_COUNTRY_DIAL_CODE) {
      throw PhoneNumberException(
          code: Code.INVALID_DIAL_CODE,
          description: 'dial codes have a min length of '
              '${Constants.MIN_LENGTH_COUNTRY_DIAL_CODE}');
    }
    return dialCode;
  }

  static String removeDialCode(String phoneNumber, p.PhoneMetadata metadata) {
    if (phoneNumber.startsWith(metadata.dialCode)) {
      return phoneNumber.substring(metadata.dialCode.length);
    }
    return phoneNumber;
  }

  /// Gets the metadata of a [nationalNumber] by providing a [dialCode]
  ///
  /// Expects a normalized [nationalNumber] that is in its international form
  static p.PhoneMetadataExtended selectMetadataMatchForDialCode(
    String dialCode,
    String nationalNumber,
    List<p.PhoneMetadataExtended> potentialFits,
  ) {
    if (potentialFits.length == 1) {
      return potentialFits[0];
    }

    for (var fit in potentialFits) {
      // if multiple fits, check leading digits to see if there is a fit
      final leadingDigits = fit.leadingDigits;

      if (leadingDigits != null && nationalNumber.startsWith(leadingDigits)) {
        return fit;
      }

      if (Validator.validateWithPattern(nationalNumber, fit)) {
        return fit;
      }
    }

    return potentialFits[0];
  }
}
