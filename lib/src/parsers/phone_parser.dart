import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/parsers/_dial_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/light_phone_parser.dart';
import 'package:phone_numbers_parser/src/parsers/parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_matcher.dart';

import '_iso_code_parser.dart';
import '_text_parser.dart';
import '_validator.dart';

/// {@template phoneNumber}
/// The [phoneNumber] can be of the sort:
///  +33 478 88 88 88,
///  0478 88 88 88,
///  478 88 88 88
/// {@endtemplate}

/// Heavy parser
///
/// This parser is more accurate than the LightPhoneParser at the expense
/// of being more computationally intensive and resulting in a bigger
/// size when imported
///
/// It also furnishes more utilities that cannot be achieved with the light parser
class PhoneParser extends Parser {
  /// parses a [phoneNumber] given an [isoCode]
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the isoCode is invalid
  @override
  PhoneNumber parseWithIsoCode(String isoCode, String phoneNumber) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    phoneNumber = InternationalPrefixParser.removeInternationalPrefix(
        phoneNumber, metadata);
    phoneNumber = DialCodeParser.removeDialCode(phoneNumber, metadata.dialCode);
    final nsn =
        NationalPrefixParser.transformLocalNsnToInternationalUsingPatterns(
            phoneNumber, metadata);
    return PhoneNumber(isoCode: metadata.isoCode, nsn: nsn);
  }

  /// parses a [phoneNumber] given a [dialCode]
  ///
  /// Use parseWithIsoCode when possible at multiple countries
  /// use the same dial code.
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the dial code is invalid
  @override
  PhoneNumber parseWithDialCode(String dialCode, String phoneNumber) {
    dialCode = DialCodeParser.normalizeDialCode(dialCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    phoneNumber = DialCodeParser.removeDialCode(phoneNumber, dialCode);
    final metadatas = MetadataFinder.getMetadatasForDialCode(dialCode);
    final metadata =
        MetadataMatcher.getMatchUsingPatterns(phoneNumber, metadatas);
    final nsn =
        NationalPrefixParser.transformLocalNsnToInternationalUsingPatterns(
      phoneNumber,
      metadata,
    );
    return PhoneNumber(isoCode: metadata.isoCode, nsn: nsn);
  }

  /// parses a [phoneNumber] given a [dialCode]
  ///
  /// Use parseWithIsoCode when possible at multiple countries
  /// use the same dial code.
  ///
  /// This assumes the phone number starts with the dial code
  ///
  /// throws a PhoneNumberException if the dial code is invalid
  @override
  PhoneNumber parseRaw(String phoneNumber) {
    phoneNumber = TextParser.normalize(phoneNumber);
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    final dialCode = DialCodeParser.extractDialCode(phoneNumber);
    return parseWithDialCode(dialCode, phoneNumber);
  }

  /// Validates a phone number using pattern mathing
  ///
  /// if a [type] is added, will validate against a specific type
  @override
  bool validate(PhoneNumber phoneNumber, [PhoneNumberType? type]) {
    return Validator.validateWithPattern(phoneNumber, type);
  }
}
