import 'dart:math';

import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:phone_numbers_parser/src/parsers/_national_number_parser.dart';
import 'package:phone_numbers_parser/src/regex/match_entirely_extension.dart';

import '../metadata/models/phone_metadata_formats.dart';
import '../iso_codes/iso_code.dart';

/// The formats a phone number can be written in.
enum PhoneNumberFormat {
  /// The international form without separators: `+33611223344`.
  e164,

  /// The dial code followed by the international number: `+33 6 11 22 33 44`.
  international,

  /// How the number is written and dialed nationally: `06 11 22 33 44`.
  national,

  /// The national significant number, without the national prefix:
  /// `6 11 22 33 44`. Use it when the dial code is displayed next to the
  /// number, `+33611223344` and `6 11 22 33 44` together read correctly.
  nsn,
}

/// The formats [PhoneNumberFormatter.formatNsn] can write, kept for the
/// deprecated `formatNsn` methods. Prefer [PhoneNumberFormat].
enum NsnFormat {
  /// The national format, with the national prefix: `0477 88 99 22`.
  national,

  /// The format used for international dialing, without the national prefix.
  international,

  /// The national format without the national prefix: `477 88 99 22`.
  ///
  /// Same grouping as [national], so it is what a text field shows when the
  /// country dial code is displayed next to it: the two together read as a
  /// valid international number.
  nationalWithoutPrefix,
}

class PhoneNumberFormatter {
  /// Formats [nsn] as [format].
  ///
  /// [isoCode] is the region the number belongs to, it provides both the dial
  /// code and the grouping rules.
  static String format(
    String nsn,
    IsoCode isoCode, [
    PhoneNumberFormat format = PhoneNumberFormat.international,
  ]) {
    final countryCode =
        MetadataFinder.findMetadataForIsoCode(isoCode).countryCode;
    if (nsn.isEmpty) {
      return switch (format) {
        PhoneNumberFormat.e164 => '+$countryCode',
        PhoneNumberFormat.international ||
        PhoneNumberFormat.national ||
        PhoneNumberFormat.nsn =>
          '',
      };
    }
    return switch (format) {
      PhoneNumberFormat.e164 => '+$countryCode$nsn',
      PhoneNumberFormat.international => '+$countryCode '
          '${_formatNsn(nsn, isoCode, NsnFormat.international)}',
      PhoneNumberFormat.national =>
        _formatNsn(nsn, isoCode, NsnFormat.national),
      PhoneNumberFormat.nsn =>
        _formatNsn(nsn, isoCode, NsnFormat.nationalWithoutPrefix),
    };
  }

  /// Formats [nsn] for display, either in its national form (with the
  /// national prefix) or in its international form (without it).
  @Deprecated('Use [format] with [PhoneNumberFormat.national] instead')
  static String formatNsn(
    String nsn,
    IsoCode isoCode, [
    NsnFormat format = NsnFormat.national,
  ]) =>
      _formatNsn(nsn, isoCode, format);

  static String _formatNsn(
    String nsn,
    IsoCode isoCode,
    NsnFormat format,
  ) {
    if (nsn.isEmpty) {
      return nsn;
    }
    // since the phone number might be incomplete, fake digits
    // are temporarily added to format a complete number.
    final missingDigits = _getMissingDigits(nsn, isoCode);
    final completePhoneNumber = nsn + missingDigits;
    final formatingRules =
        MetadataFinder.findMetadataFormatsForIsoCode(isoCode);
    // Prefer a format that matches the number as it is, the faked digits are
    // only there to format an incomplete number.
    final formatingRule = _getMatchingFormatRules(
          formatingRules: formatingRules,
          nsn: nsn,
        ) ??
        _getMatchingFormatRules(
          formatingRules: formatingRules,
          nsn: completePhoneNumber,
        );
    // for incomplete phone number

    if (formatingRule == null) {
      return nsn;
    }
    var transformRule = formatingRule.format;
    // if there is an international format, we use it
    final intlFormat = formatingRule.intlFormat;
    if (format == NsnFormat.international &&
        intlFormat != null &&
        intlFormat != 'NA') {
      transformRule = intlFormat;
    } else if (format == NsnFormat.national) {
      transformRule = _withNationalPrefix(
        formatRule: transformRule,
        nationalPrefixRule: formatingRule.nationalPrefixFormattingRule,
        nationalPrefix:
            MetadataFinder.findMetadataForIsoCode(isoCode).nationalPrefix,
      );
    }

    var formatted = NationalNumberParser.applyTransformRules(
      appliedTo: completePhoneNumber,
      pattern: formatingRule.pattern,
      transformRule: transformRule,
    );
    formatted = _removeMissingDigits(formatted, missingDigits);
    return formatted;
  }

  /// Prepends the national prefix to [formatRule] using the metadata
  /// [nationalPrefixRule], where `$NP` stands for the national prefix and `$FG`
  /// for the first group reference of the format.
  ///
  /// The rule is spliced in place of the first group reference, the way
  /// libphonenumber does it. Argentina's mobile format is `$2 15-$3-$4` with
  /// the rule `$NP$FG`, which becomes `0$2 15-$3-$4`: `$FG` refers to the
  /// first group used by the format, not to the first group of the pattern.
  ///
  /// A country without a national prefix keeps its format untouched.
  static String _withNationalPrefix({
    required String formatRule,
    required String? nationalPrefixRule,
    required String? nationalPrefix,
  }) {
    if (nationalPrefixRule == null ||
        nationalPrefixRule.isEmpty ||
        nationalPrefixRule == 'NA' ||
        nationalPrefix == null ||
        nationalPrefix.isEmpty) {
      return formatRule;
    }
    final firstGroupReference = RegExp(r'\$\d').firstMatch(formatRule);
    if (firstGroupReference == null) {
      return formatRule;
    }
    final rule = nationalPrefixRule
        .replaceAll(r'$NP', nationalPrefix)
        .replaceAll(r'$FG', firstGroupReference.group(0)!);
    return formatRule.replaceRange(
      firstGroupReference.start,
      firstGroupReference.end,
      rule,
    );
  }

  static String _removeMissingDigits(String formatted, String missingDigits) {
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
  static String _getMissingDigits(String nsn, IsoCode isoCode) {
    final lengthRule = MetadataFinder.findMetadataLengthForIsoCode(isoCode);

    final minLength = max(lengthRule.fixedLine.first, lengthRule.mobile.first);
    // added digits so we match the pattern in case of an incomplete phone number
    var missingDigits = '';

    while ((nsn + missingDigits).length < minLength) {
      missingDigits += '9';
    }
    return missingDigits;
  }

  /// gets the matching format rule,
  /// if there is only one formatting rule return it,
  /// else finds the formatting rule that better matches the phone number
  static PhoneMetadataFormat? _getMatchingFormatRules({
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
      final matchPattern = rules.pattern.matchEntirely(nsn);
      if (matchLeading != null && matchPattern != null) {
        return rules;
      }
    }

    return null;
  }
}
