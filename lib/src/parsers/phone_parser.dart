import 'package:meta/meta.dart';
import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_country_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_number_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_text_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_matcher.dart';

/// {@template phoneNumber}
/// Parses a phone number given caller or destination information.
///
/// The logic is:
///
///  1. Remove the international prefix / exit code
///    a. if caller is provided remove the international prefix / exit code
///    b. if caller is not provided be a best guess is done with a possible destination
///       country
///  2. Find destination country
///    a. if no destination country was provided, the destination is assumed to be the
///       same as the caller
///    b. if no caller was provided a best guess is estimated by looking at
///       the first digits to see if they match a country. Since multiple countries
///       share the same country code, pattern matching might be used when there are
///       multiple matches.
///  3. Extract the country code with the country information
///  4. Transform a local NSN to an international version
///
/// {@endtemplate}
abstract class PhoneParser {
  @internal
  static PhoneNumber parse(
    String phoneNumber, {
    IsoCode? callerCountry,
    IsoCode? destinationCountry,
  }) {
    phoneNumber = TextParser.normalize(phoneNumber);
    final callerMetadata = callerCountry != null
        ? MetadataFinder.getMetadataForIsoCode(callerCountry)
        : null;
    var destinationMetadata = destinationCountry != null
        ? MetadataFinder.getMetadataForIsoCode(destinationCountry)
        : null;

    final withoutExitCode = InternationalPrefixParser.removeExitCode(
      phoneNumber,
      destinationCountryMetadata: destinationMetadata,
      callerCountryMetadata: callerMetadata,
    );
    // if no destination metadata was provided we have to find it,
    destinationMetadata ??= _findDestinationMetadata(
      phoneWithoutExitCode: withoutExitCode,
      callerMetadata: callerMetadata,
    );
    final national = CountryCodeParser.removeCountryCode(
      withoutExitCode,
      destinationMetadata.countryCode,
    );
    var nsn = NationalNumberParser.removeNationalPrefix(
      national,
      destinationMetadata,
    );
    nsn = NationalNumberParser.transformLocalNsnToInternationalUsingPatterns(
      nsn,
      destinationMetadata,
    );
    // at this point we have the phone number that has been processed, but
    // if it is invalid, we remove the processing of the nsn part
    // this allows for a better behavior in some input usages where the
    // text is changed on validity.
    final parsed = PhoneNumber(isoCode: destinationMetadata.isoCode, nsn: nsn);
    if (parsed.isValid()) return parsed;
    return PhoneNumber(isoCode: destinationMetadata.isoCode, nsn: national);
  }

  // find destination of a normalized phone number, which supposedly
  // starts with a country code.
  static PhoneMetadata _findDestinationMetadata({
    required String phoneWithoutExitCode,
    required PhoneMetadata? callerMetadata,
  }) {
    final callerNationalPrefix = callerMetadata?.nationalPrefix;
    // if it starts with the national prefix of the caller then we can safely
    // assume that the caller calls in the same country
    if (callerMetadata != null &&
        callerNationalPrefix != null &&
        phoneWithoutExitCode.startsWith(callerNationalPrefix)) {
      return callerMetadata;
    }
    // if no caller was provided we need to make a best guess given the country code
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
