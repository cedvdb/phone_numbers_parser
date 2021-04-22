import 'package:phone_numbers_parser/src/models/country.dart';

import '../exceptions.dart';
import 'extractor.dart';

/// Parsing result to not return a PhoneNumber and avoid circular dep.
class ParsingResult {
  final Country country;
  final String nsn;
  final String nationalNumberUnparsed;
  ParsingResult({
    required this.country,
    required this.nsn,
    required this.nationalNumberUnparsed,
  });
}

// This class mainly contains the public methods bodies which
// are mainly summaries of what happens and use the [PrefixParser]
// to do the parsing business logic
// Therefor this class must stay clean as to be readable.

/// Parser to do various operations on Strings representing phone numbers.
class PhoneNumberParser {
  /// Extracts the necessary information from a normalized [phoneNumber]
  /// to return a [PhoneNumber].
  ///
  /// The [phoneNumber] is expected to contain the country dial code.
  /// It will return a valid result if the [phoneNumber] start with +, 00 or 011
  /// as international prefix.
  ///
  /// If the phoneNumber does not contain a country dial code, use [parseNational]
  ///
  /// Throws [PhoneNumberException].
  static ParsingResult parse(String phoneNumber) {
    final internationalPrefixResult =
        Extractor.extractInternationalPrefix(phoneNumber);
    final dialCodeResult = Extractor.extractDialCode(
      internationalPrefixResult.phoneNumber,
    );

    if (dialCodeResult.extracted == null) {
      throw PhoneNumberException(
        code: Code.INVALID_DIAL_CODE,
        description: 'not found for ${internationalPrefixResult.phoneNumber}',
      );
    }

    return parseWithDialCode(
      dialCodeResult.extracted!,
      dialCodeResult.phoneNumber,
    );
  }

  /// Converts a normalized [nationalNumber] to a [PhoneNumber],
  /// the [PhoneNumber.nsn] is the national number valid internationally
  /// with the leading digits for the region and so on
  static ParsingResult parseWithDialCode(
    String dialCode,
    String nationalNumber,
  ) {
    // multiple countries share the same dial code
    final countryResult = Extractor.extractCountry(nationalNumber, dialCode);
    if (countryResult.extracted == null) {
      throw PhoneNumberException(
        code: Code.INVALID_DIAL_CODE,
        description: 'The country could not be guessed',
      );
    }
    return ParsingResult(
      country: countryResult.extracted!,
      nsn: countryResult.phoneNumber,
      nationalNumberUnparsed: nationalNumber,
    );
  }

  static ParsingResult parseWithIsoCode(String isoCode, String nationalNumber) {
    final country = Country.fromIsoCode(isoCode);
    final nationalNumberResult =
        Extractor.extractNationalPrefix(nationalNumber, country);
    return ParsingResult(
      country: country,
      nsn: nationalNumberResult.phoneNumber,
      nationalNumberUnparsed: nationalNumber,
    );
  }
}
