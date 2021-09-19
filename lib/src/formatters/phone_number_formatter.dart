import 'dart:math';

import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_regexp_manager.dart';

class PhoneNumberFormatter {
  /// format national number for international use
  String formatNsn(PhoneNumber phoneNumber) {
    final missingDigits = _getMissingDigits(phoneNumber);
    final completePhoneNumber = phoneNumber.nsn + missingDigits;
    final formatingRules =
        MetadataFinder.getMetadataFormatsForIsoCode(phoneNumber.isoCode);
    final formatingRule = _getMatchingFormatRules(
      formatingRules: formatingRules,
      nsn: completePhoneNumber,
    );
    // for incomplete phone number

    if (formatingRule == null) {
      return phoneNumber.nsn;
    }
    var transformRule = formatingRule.format;
    // if there is an international format, we use it
    final intlFormat = formatingRule.intlFormat;
    if (intlFormat != null && intlFormat != 'NA') {
      transformRule = intlFormat;
    }

    var formatted = RegexpManager.applyTransformRules(
      appliedTo: completePhoneNumber,
      pattern: formatingRule.pattern,
      transformRule: transformRule,
    );
    formatted = _removeMissingDigits(formatted, missingDigits);
    return formatted;
  }

  String _removeMissingDigits(String formatted, String missingDigits) {
    while (missingDigits.isNotEmpty) {
      // not an ending digit
      final isEndingWithSpecialChar =
          int.tryParse(formatted[formatted.length - 1]) == null;
      if (isEndingWithSpecialChar) {
        formatted = formatted.substring(0, formatted.length - 1);
      } else {
        formatted = formatted.substring(0, formatted.length - 1);
        missingDigits = missingDigits.substring(0, missingDigits.length - 1);
      }
    }
    final isEndingWithSpecialChar =
        int.tryParse(formatted[formatted.length - 1]) == null;
    if (isEndingWithSpecialChar) {
      formatted = formatted.substring(0, formatted.length - 1);
    }
    return formatted;
  }

  /// returns 9's to have a valid length number
  String _getMissingDigits(PhoneNumber phoneNumber) {
    final lengthRule =
        MetadataFinder.getMetadataLengthForIsoCode(phoneNumber.isoCode);

    final minLength = max(lengthRule.fixedLine.first, lengthRule.mobile.first);
    // added digits so we match the pattern in case of an incomplete phone number
    var missingDigits = '';

    while ((phoneNumber.nsn + missingDigits).length < minLength) {
      missingDigits += '9';
    }
    return missingDigits;
  }

  /// gets the matching format rule
  PhoneMetadataFormat? _getMatchingFormatRules({
    required PhoneMetadataFormats formatingRules,
    required String nsn,
  }) {
    if (formatingRules.isEmpty) {
      return null;
    }

    if (formatingRules.length == 1) {
      return formatingRules[0];
    }

    for (var rules in formatingRules) {
      // phonenumberkit seems to be using the last leading digit pattern
      // from the list of pattern so that's what we are going to do here as well
      final matchLeading = RegExp(rules.leadingDigits.last).matchAsPrefix(nsn);
      final matchPattern = RegexpManager.matchEntirely(rules.pattern, nsn);
      if (matchLeading != null && matchPattern != null) {
        return rules;
      }
    }

    return null;
  }
}
