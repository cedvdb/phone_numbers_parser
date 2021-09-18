import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/parsers/_country_calling_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_iso_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/base_phone_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_matcher.dart';

import '_text_parser.dart';
import '_validator.dart';

/// light parser, faster and lighter for tree shaking
///
/// The difference with the PhoneParser is that this does not use pattern information
/// to parse a phone number but it reduces the file size after tree shaking
/// (assuming the other parser was not imported).
///
/// If the objective is the most accuracy at the expense of file size and speed
/// then the other parser should be used.
/// If the objective is decent accuracy with lighter file size then this parser
/// can be used.
class LightPhoneParser extends BasePhoneParser {
  /// parses a [phoneNumber] given an [isoCode]
  ///
  /// The [phoneNumber] can be of the sort:
  ///  +33 478 88 88 88
  ///  0478 88 88 88
  ///  478 88 88 88
  ///
  /// throws a PhoneNumberException if the isoCode is invalid
  @override
  PhoneNumber parseWithIsoCode(
    String isoCode,
    String phoneNumber,
  ) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    phoneNumber =
        CountryCodeParser.removeCountryCode(phoneNumber, metadata.countryCode);
    final nsn =
        NationalPrefixParser.removeNationalPrefix(phoneNumber, metadata);
    return PhoneNumber(nsn: nsn, isoCode: metadata.isoCode);
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
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    phoneNumber = CountryCodeParser.removeCountryCode(phoneNumber, countryCode);
    var metadatas = MetadataFinder.getMetadatasForCountryCode(countryCode);
    metadatas =
        MetadataMatcher.reducePotentialMetadatasFits(phoneNumber, metadatas);
    // this line will give some fake results between US and CA but that's the
    // best we can do by not using patterns
    final metadata = metadatas[0];
    final nsn =
        NationalPrefixParser.removeNationalPrefix(phoneNumber, metadata);
    return PhoneNumber(isoCode: metadata.isoCode, nsn: nsn);
  }

  @override
  PhoneNumber parseRaw(String phoneNumber) {
    phoneNumber = TextParser.normalize(phoneNumber);
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    final countryCode = CountryCodeParser.extractCountryCode(phoneNumber);
    return parseWithCountryCode(countryCode, phoneNumber);
  }

  /// Validates a phone number using length information
  ///
  /// To validate with pattern use the PhoneParser.validate
  ///
  /// if a [type] is added, will validate against a specific type
  @override
  bool validate(PhoneNumber phoneNumber, [PhoneNumberType? type]) {
    return Validator.validateWithLength(phoneNumber, type);
  }
}
