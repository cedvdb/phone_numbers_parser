import 'package:meta/meta.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/parsers/_country_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_number_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_matcher.dart';

import '_iso_code_parser.dart';
import '_text_parser.dart';
import '_validator.dart';

/// {@template phoneNumber}
/// The [phoneNumber] can be of the sort:
///  +33 6 86 57 90 14,
///  06 86 57 90 14,
///  6 86 57 90 14
/// {@endtemplate}

/// For parsing phone numbers
///
/// Use [fromNational] when you know that a phone number is a
/// national version (phone number input)
///
/// Use [fromIsoCode] over [fromCountryCode] as it is faster
/// Use [fromCountryCode] over [fromRaw] as it is faster
class PhoneParser {
  /// parses a [national] phone number given a country code
  ///
  /// This is useful for when you know in advance that a phone
  /// number is a national version.
  /// For example in a phone number input with two inputs for the
  /// country code and national number
  @internal
  static PhoneNumber fromNational(String isoCode, String national) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);

    national = TextParser.normalize(national);
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    final nsn =
        NationalNumberParser.transformLocalNsnToInternationalUsingPatterns(
            national, metadata);
    final result = PhoneNumber(isoCode: metadata.isoCode, nsn: nsn);
    // we only want to modify the national number when it is valid
    if (result.validate()) return result;
    return PhoneNumber(isoCode: isoCode, nsn: national);
  }

  @Deprecated('use static method [PhoneNumber.fromNational] instead')
  PhoneNumber parseNational(String isoCode, String national) =>
      PhoneParser.fromNational(isoCode, national);

  /// parses a [phoneNumber] given an [isoCode]
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the isoCode is invalid
  @internal
  static PhoneNumber fromIsoCode(String isoCode, String phoneNumber) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    phoneNumber = InternationalPrefixParser.removeInternationalPrefix(
      phoneNumber,
      countryCode: metadata.countryCode,
      metadata: metadata,
    );
    phoneNumber =
        CountryCodeParser.removeCountryCode(phoneNumber, metadata.countryCode);
    return fromNational(isoCode, phoneNumber);
  }

  @Deprecated('use static method [PhoneNumber.fromIsoCode] instead')
  PhoneNumber parseWithIsoCode(String isoCode, String phoneNumber) =>
      PhoneParser.fromIsoCode(isoCode, phoneNumber);

  /// parses a [phoneNumber] given a [countryCode]
  ///
  /// Use parseWithIsoCode when possible as multiple countries
  /// use the same country calling code.
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the country calling code is invalid
  @internal
  static PhoneNumber fromCountryCode(
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
    return fromNational(metadata.isoCode, phoneNumber);
  }

  @Deprecated('use static method [PhoneNumber.fromCountryCode] instead')
  PhoneNumber parseWithCountryCode(
    String countryCode,
    String phoneNumber,
  ) =>
      PhoneParser.fromCountryCode(countryCode, phoneNumber);

  /// parses a [phoneNumber] given a [countryCode]
  ///
  /// Use parseWithIsoCode when possible as multiple countries
  /// use the same country calling code.
  ///
  /// This assumes the phone number starts with the country calling code
  ///
  /// throws a PhoneNumberException if the country calling code is invalid
  @internal
  static PhoneNumber fromRaw(String phoneNumber) {
    phoneNumber = TextParser.normalize(phoneNumber);
    phoneNumber = InternationalPrefixParser.removeInternationalPrefix(
      phoneNumber,
    );
    final countryCode = CountryCodeParser.extractCountryCode(phoneNumber);
    return fromCountryCode(countryCode, phoneNumber);
  }

  @Deprecated('use static method [PhoneNumber.fromRaw] instead')
  PhoneNumber parseRaw(String phoneNumber) => PhoneParser.fromRaw(phoneNumber);

  /// Validates a phone number using pattern mathing
  ///
  /// if a [type] is added, will validate against a specific type
  @internal
  static bool validate(PhoneNumber phoneNumber, [PhoneNumberType? type]) {
    return Validator.validateWithPattern(phoneNumber, type);
  }
}
