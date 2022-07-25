import 'package:meta/meta.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_country_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_number_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_matcher.dart';

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
  /// parses a [national] phone number given an iso code
  ///
  /// The difference with fromIsoCode is that here we assume that the phoneNumber
  /// is a national one. Therefore some parsing steps are skipped.
  ///
  /// This is useful for when you know in advance that a phone
  /// number is a national version.
  /// For example in a phone number input with two inputs for the
  /// country code and national number
  @internal
  static PhoneNumber fromNational(IsoCode isoCode, String national) {
    national = TextParser.normalize(national);
    final result = _parse(isoCode, national);
    // we only want to modify the national number when it is valid
    if (result.validate()) return result;
    return PhoneNumber(isoCode: isoCode, nsn: national);
  }

  /// parses a [phoneNumber] given an [isoCode]
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the isoCode is invalid
  @internal
  static PhoneNumber fromIsoCode(IsoCode isoCode, String phoneNumber) {
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    // we now have national which is the phone number that will be transformed
    // to nsn. If the result is not valid, we will keep the original input as
    // the nsn. That is because for the national we assume that if the number
    // starts with the country code, it is in fact the country code.
    // however that's not always the case, some countries like KZ can have an nsn
    // starting with the same digits as the country code.
    // For example we could do fromIsoCode('KZ', '7710009998')
    // the below code will first assume that the leading 7 is the country code
    // then will realize the phone number is invalid when the 7 is removed
    // and will return a result with the original input, which is valid
    final withoutIntlPrefix =
        InternationalPrefixParser.removeInternationalPrefix(
      phoneNumber,
      countryCode: metadata.countryCode,
      metadata: metadata,
    );

    final withoutCountryCode = CountryCodeParser.removeCountryCode(
        withoutIntlPrefix, metadata.countryCode);
    var national = withoutCountryCode;
    // if a country code did not immediately follow the international prefix
    // then it was not an international prefix by definition
    if (withoutIntlPrefix.length == withoutCountryCode.length) {
      national = withoutCountryCode;
    }

    final result = _parse(isoCode, national);
    // we only want to modify the national number when it is valid
    if (result.validate()) return result;
    return PhoneNumber(isoCode: isoCode, nsn: phoneNumber);
  }

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
    final withoutIntlPrefix =
        InternationalPrefixParser.removeInternationalPrefix(
      phoneNumber,
      countryCode: countryCode,
    );
    final withoutCountryCode =
        CountryCodeParser.removeCountryCode(withoutIntlPrefix, countryCode);
    var national = withoutCountryCode;
    // if a country code did not immediately follow the international prefix
    // then it was not an international prefix by definition
    if (withoutIntlPrefix.length == withoutCountryCode.length) {
      national = phoneNumber;
    }
    final metadatas = MetadataFinder.getMetadatasForCountryCode(countryCode);
    final metadata = MetadataMatcher.getMatchUsingPatterns(national, metadatas);
    final result = _parse(metadata.isoCode, national);
    // we only want to modify the national number when it is valid
    if (result.validateLength()) return result;
    return PhoneNumber(isoCode: metadata.isoCode, nsn: phoneNumber);
  }

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
    return fromCountryCode(
        countryCode, phoneNumber.substring(countryCode.length));
  }

  /// parse a phone number by providing an [isoCode] and the [national]
  /// this will transform the national from its local version to international
  /// this function assumes well formed params
  static PhoneNumber _parse(IsoCode isoCode, String national) {
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    final nsn =
        NationalNumberParser.transformLocalNsnToInternationalUsingPatterns(
            national, metadata);
    return PhoneNumber(isoCode: metadata.isoCode, nsn: nsn);
  }

  /// Validates a phone number using pattern matching
  ///
  /// if a [type] is added, will validate against a specific type
  @internal
  static bool validate(PhoneNumber phoneNumber, [PhoneNumberType? type]) {
    return Validator.validateWithPattern(phoneNumber, type);
  }
}
