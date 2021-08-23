import 'dart:math';

import 'package:phone_number_metadata/phone_number_metadata.dart' as p;
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/constants/constants.dart';
import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_numbers_parser/src/parsers/_validator.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';

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
    if (dialCode.length < Constants.MIN_LENGTH_COUNTRY_DIAL_CODE ||
        dialCode.length > Constants.MAX_LENGTH_COUNTRY_DIAL_CODE) {
      throw PhoneNumberException(
          code: Code.INVALID_DIAL_CODE,
          description: 'dial code invalid length');
    }
    return dialCode;
  }

  /// tries to find a dial code at the start of a phone number
  static String extractDialCode(String phoneNumber) {
    final maxLength =
        min(phoneNumber.length, Constants.MAX_LENGTH_COUNTRY_DIAL_CODE);
    var potentialDialCode = phoneNumber.substring(0, maxLength);
    potentialDialCode = normalizeDialCode(potentialDialCode);
    for (var i = 1; i <= potentialDialCode.length; i++) {
      try {
        final potentialDialCodeFit = potentialDialCode.substring(0, i);
        MetadataFinder.getMetadatasForDialCode(potentialDialCodeFit);
        return potentialDialCodeFit;
        // ignore: empty_catches
      } catch (e) {}
    }
    throw PhoneNumberException(
        code: Code.NOT_FOUND,
        description: 'dial code not found in phone number');
  }

  static String removeDialCode(String phoneNumber, String dialCode) {
    if (phoneNumber.startsWith(dialCode)) {
      return phoneNumber.substring(dialCode.length);
    }
    return phoneNumber;
  }

  /// Gets the metadata of a [nationalNumber] by providing a [dialCode]
  ///
  /// Expects a normalized [nationalNumber] that is in its international form
  // static p.PhoneMetadata selectMetadataMatchForDialCode({
  //   required String dialCode,
  //   required String nationalNumber,
  //   required List<p.PhoneMetadata> potentialFits,
  //   required bool usePatternMatching,
  // }) {
  //   if (potentialFits.length == 1) {
  //     return potentialFits[0];
  //   }

  //   for (var fit in potentialFits) {
  //     // if multiple fits, check leading digits to see if there is a fit
  //     final leadingDigits = fit.leadingDigits;

  //     if (leadingDigits != null && nationalNumber.startsWith(leadingDigits)) {
  //       return fit;
  //     }
  //     if (usePatternMatching) {
  //       final isValidForIso = Validator.validateWithPattern(
  //           PhoneNumber(nsn: nationalNumber, isoCode: fit.isoCode));

  //       if (isValidForIso) {
  //         return fit;
  //       }
  //     }
  //   }

  //   return potentialFits[0];
  // }

}
