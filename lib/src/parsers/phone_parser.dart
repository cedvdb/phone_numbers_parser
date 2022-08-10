import 'dart:html';

import 'package:meta/meta.dart';
import 'package:phone_number_metadata/phone_number_metadata.dart';
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
  @internal
  static PhoneNumber parse(
    String phoneNumber, {
    IsoCode? callerCountry,
    IsoCode? destinationCountry,
  }) {
    final callerMatadata = callerCountry != null
        ? MetadataFinder.getMetadataForIsoCode(callerCountry)
        : null;
    var destinationMetadata = destinationCountry != null
        ? MetadataFinder.getMetadataForIsoCode(destinationCountry)
        : null;

    final withoutExitCode = InternationalPrefixParser.removeExitCode(
      phoneNumber,
      destinationCountryMetadata: destinationMetadata,
      callerCountryMetadata: callerMatadata,
    );
    // if no destination metadata was provided we have to find it,
    // the same destination as the caller is assumed if caller is provided
    destinationMetadata ??= callerMatadata ??
        _findDestinationMetadata(phoneWithoutExitCode: withoutExitCode);
    final countryCode = CountryCodeParser.removeCountryCode(
        phoneNumber, destinationMetadata.countryCode);
    final national = withoutExitCode.substring(countryCode.length);
    var nsn = NationalNumberParser.removeNationalPrefix(
      national,
      destinationMetadata,
    );
    nsn = NationalNumberParser.transformLocalNsnToInternationalUsingPatterns(
      nsn,
      destinationMetadata,
    );
    return PhoneNumber(isoCode: destinationMetadata.isoCode, nsn: nsn);
  }

  // find destination of a normalized phone number, which supposedly
  // starts with a country code.
  static PhoneMetadata _findDestinationMetadata({
    required String phoneWithoutExitCode,
  }) {
    final countryCode =
        CountryCodeParser.extractCountryCode(phoneWithoutExitCode);
    final national =
        CountryCodeParser.removeCountryCode(phoneWithoutExitCode, countryCode);
    // multiple countries use the same country code
    final metadatas = MetadataFinder.getMetadatasForCountryCode(countryCode);
    // if multiple countries share the same country code, patterns on the national number
    // is used to find the correct country.
    return MetadataMatcher.getMatchUsingPatterns(national, metadatas);
  }
}
