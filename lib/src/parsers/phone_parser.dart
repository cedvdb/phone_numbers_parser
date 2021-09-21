import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/parsers/_country_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/light_phone_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_matcher.dart';

import '_iso_code_parser.dart';
import '_text_parser.dart';
import '_validator.dart';

/// For parsing phone numbers
///
/// Use [parseNational] when you know that a phone number is a
/// national version (phone number input)
///
/// Use [parseWithIsoCode] over [parseWithCountryCode] as it is faster
/// Use [parseWithCountryCode] over [parseRaw] as it is faster
///
/// Note: This parser is more accurate than the LightPhoneParser at the expense
/// of being more computationally intensive and resulting in a bigger
/// size when imported
class PhoneParser extends LightPhoneParser {
  @override
  PhoneNumber parseNational(String isoCode, String national) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);

    national = TextParser.normalize(national);
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    final nsn =
        NationalPrefixParser.transformLocalNsnToInternationalUsingPatterns(
            national, metadata);
    return PhoneNumber(isoCode: metadata.isoCode, nsn: nsn);
  }

  @override
  PhoneNumber parseWithIsoCode(String isoCode, String phoneNumber) {
    return super.parseWithIsoCode(isoCode, phoneNumber);
  }

  @override
  @Deprecated(
      'renamed to parse with countryCode, dial code was semantically incorrect')
  PhoneNumber parseWithDialCodeCode(String dialCode, String phoneNumber) {
    return parseWithCountryCode(dialCode, phoneNumber);
  }

  @override
  PhoneNumber parseWithCountryCode(
    String countryCode,
    String phoneNumber,
  ) {
    countryCode = CountryCodeParser.normalizeCountryCode(countryCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    phoneNumber = InternationalPrefixParser.removeInternationalPrefix(
      phoneNumber,
      countryCode: countryCode,
    );
    phoneNumber = CountryCodeParser.removeCountryCode(phoneNumber, countryCode);
    final metadatas = MetadataFinder.getMetadatasForCountryCode(countryCode);
    final metadata =
        MetadataMatcher.getMatchUsingPatterns(phoneNumber, metadatas);
    return parseNational(metadata.isoCode, phoneNumber);
  }

  @override
  PhoneNumber parseRaw(String phoneNumber) {
    return super.parseRaw(phoneNumber);
  }

  /// Validates a phone number using pattern mathing
  ///
  /// if a [type] is added, will validate against a specific type
  @override
  bool validate(PhoneNumber phoneNumber, [PhoneNumberType? type]) {
    return Validator.validateWithPattern(phoneNumber, type);
  }
}
