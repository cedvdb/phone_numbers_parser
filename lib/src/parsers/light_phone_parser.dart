import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_matcher.dart';
import '_country_code_parser.dart';
import '_international_prefix_parser.dart';
import '_iso_code_parser.dart';
import '_national_prefix_parser.dart';
import '_text_parser.dart';
import '_validator.dart';

/// {@template phoneNumber}
/// The [phoneNumber] can be of the sort:
///  +33 6 86 57 90 14,
///  06 86 57 90 14,
///  6 86 57 90 14
///
/// Note that it is possible for a phone number to start
/// with the same digits as the country code eg: +4141...
/// If the first digits of the [phoneNumber] are the ones from the country
/// provided then it will be assumed to not be part of the national number.
///
/// When you know in advance that the [phoneNumber] is a national one, use [parseNational]
///
/// {@endtemplate}

/// base class for PhoneParser and LightPhoneParser
class LightPhoneParser {
  /// parses a [national] phone number given a country code
  ///
  /// This is useful for when you know in advance that a phone
  /// number is a national version. For example in a phone number input
  PhoneNumber parseNational(String isoCode, String national) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);

    national = TextParser.normalize(national);
    final metadata = MetadataFinder.getMetadataForIsoCode(isoCode);
    final nsn = NationalPrefixParser.removeNationalPrefix(national, metadata);
    return PhoneNumber(isoCode: metadata.isoCode, nsn: nsn);
  }

  /// parses a [phoneNumber] given an [isoCode]
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the isoCode is invalid
  PhoneNumber parseWithIsoCode(String isoCode, String phoneNumber) {
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
    return parseNational(isoCode, phoneNumber);
  }

  /// parses a [phoneNumber] given a [countryCode]
  ///
  /// Use parseWithIsoCode when possible as multiple countries
  /// use the same country calling code.
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the country calling code is invalid
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
    // this line will give some false results between US and CA but that's the
    // best we can do by not using patterns
    final metadata = metadatas[0];
    return parseNational(metadata.isoCode, phoneNumber);
  }

  @Deprecated(
      'renamed to parse with countryCode, dial code was semantically incorrect')
  PhoneNumber parseWithDialCodeCode(String dialCode, String phoneNumber) {
    return parseWithCountryCode(dialCode, phoneNumber);
  }

  /// parses a [phoneNumber] given a [countryCode]
  ///
  /// Use parseWithIsoCode when possible as multiple countries
  /// use the same country calling code.
  ///
  /// This assumes the phone number starts with the country calling code
  ///
  /// throws a PhoneNumberException if the country calling code is invalid
  PhoneNumber parseRaw(String phoneNumber) {
    phoneNumber = TextParser.normalize(phoneNumber);
    phoneNumber = InternationalPrefixParser.removeInternationalPrefix(
      phoneNumber,
    );
    final countryCode = CountryCodeParser.extractCountryCode(phoneNumber);
    return parseWithCountryCode(countryCode, phoneNumber);
  }

  /// Validates a phone number using length information
  ///
  /// To validate with pattern use the PhoneParser.validate
  ///
  /// if a [type] is added, will validate against a specific type
  bool validate(PhoneNumber phoneNumber, [PhoneNumberType? type]) {
    return Validator.validateWithLength(phoneNumber, type);
  }

  /// change the iso code of a phone number
  ///
  /// return a new [PhoneNumber] with a new isoCode and an nsn that might have
  /// been modified
  PhoneNumber copyWithIsoCode(PhoneNumber phoneNumber, String isoCode) {
    return parseWithIsoCode(isoCode, phoneNumber.nsn);
  }

  /// Extracts phone numbers from a [text].
  /// The potential phone numbers returned are not checked for their validity.
  /// It is possible that a match could be a date or anything else ressembling a phone number.
  /// To verify it is in fact a phone number you can parse it and check its validity
  Iterable<Match> findPotentialPhoneNumbers(String text) {
    return TextParser.findPotentialPhoneNumbers(text);
  }
}
