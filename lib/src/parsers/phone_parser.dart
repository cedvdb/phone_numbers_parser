import 'package:meta/meta.dart';
import 'package:phone_numbers_parser/src/validation/validator.dart';

import '../../phone_numbers_parser.dart';
import '../metadata/metadata_finder.dart';
import '../metadata/models/phone_metadata.dart';
import '_country_code_parser.dart';
import '_international_prefix_parser.dart';
import '_national_number_parser.dart';
import '_text_parser.dart';

/// {@template phoneNumber}
/// Parses a phone number given caller or destination information.
///
/// The logic is:
///
///  1. Remove the international prefix / exit code
///    a. if caller is provided remove the international prefix / exit code
///    b. if caller is not provided a best guess is done with a possible destination
///       country
///  2. Find destination country
///    a. if no destination country was provided, we check if the caller national prefix
///       is there in which case it's the destination is the same as the caller country.
///    b. else a best guess is estimated by looking at the first digits
///       to see if they match a country.
///       Since multiple countries share the same country code,
///       pattern matching might be used when there are multiple matches.
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
    phoneNumber = TextParser.normalizePhoneNumber(phoneNumber);
    final callerMetadata = callerCountry != null
        ? MetadataFinder.findMetadataForIsoCode(callerCountry)
        : null;

    var destinationMetadata = destinationCountry != null
        ? MetadataFinder.findMetadataForIsoCode(destinationCountry)
        : null;

    final (exitCode, withoutExitCode) =
        InternationalPrefixParser.extractExitCode(
      phoneNumber,
      destinationCountryMetadata: destinationMetadata,
      callerCountryMetadata: callerMetadata,
    );

    // if no destination metadata was provided we have to find it,
    destinationMetadata ??= _findDestinationMetadata(
      exitCode: exitCode,
      phoneWithoutExitCode: withoutExitCode,
      callerMetadata: callerMetadata,
    );
    var national = withoutExitCode;
    // if there was an exit code then it is an international number followed by
    // a country code.
    // otherwise if the phone number starts with a country code, we check
    // if the phone number is valid as is and use that, other wise if it is valid
    // without the country code we remove the country code.
    final countryCode = destinationMetadata.countryCode;
    if (exitCode.isNotEmpty && national.length >= countryCode.length) {
      national = national.substring(countryCode.length);
    } else if (national.startsWith(countryCode)) {
      final withoutCountryCode = national.substring(countryCode.length);
      final (_, newNational) = NationalNumberParser.extractNationalPrefix(
        withoutCountryCode,
        destinationMetadata,
      );
      final isValid =
          Validator.validateWithPattern(destinationMetadata.isoCode, national);
      final isValidWithoutCountryCode = Validator.validateWithPattern(
        destinationMetadata.isoCode,
        newNational,
      );
      if (!isValid && isValidWithoutCountryCode) {
        national = newNational;
      }
    }

    final containsCountryCode = national.length != withoutExitCode.length;
    // normally a phone number should not contain a national prefix after the country
    // code. However we let it slide to cover a wider range of incorrect input
    var (_, nsn) = NationalNumberParser.extractNationalPrefix(
      national,
      destinationMetadata,
    );
    // if the phone number contained a country code, it should in its international form
    // and we should not transform it
    if (!containsCountryCode) {
      nsn = NationalNumberParser.transformLocalNsnToInternationalUsingPatterns(
        nsn,
        destinationMetadata,
      );
    }

    // at this point we have the phone number that has been processed, but
    // if it is invalid, we remove the processing of the nsn part
    // this allows for a better behavior in some widget input usages where the
    // text is changed on validity.
    final parsed = PhoneNumber(isoCode: destinationMetadata.isoCode, nsn: nsn);
    if (parsed.isValid()) return parsed;
    return PhoneNumber(isoCode: destinationMetadata.isoCode, nsn: national);
  }

  // find destination of a normalized phone number, which supposedly
  // starts with a country code.
  static PhoneMetadata _findDestinationMetadata({
    required String exitCode,
    required String phoneWithoutExitCode,
    required PhoneMetadata? callerMetadata,
  }) {
    // if there was not an exit code then we can use the caller metadata
    // since we did not exit
    if (exitCode.isEmpty && callerMetadata != null) {
      return callerMetadata;
    }
    // if no caller was provided we need to make a best guess given the country code
    final (countryCode, nsn) =
        CountryCodeParser.extractCountryCode(phoneWithoutExitCode);
    // multiple countries use the same country code
    final metadata =
        MetadataFinder.findMetadataForCountryCode(countryCode, nsn);

    return metadata ??
        callerMetadata ??
        // default if nothing was found.
        MetadataFinder.findMetadataForIsoCode(IsoCode.US);
  }
}
