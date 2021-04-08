import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';

import '../exceptions.dart';
import 'extractor.dart';

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
  static PhoneNumber parse(String phoneNumber) {
    final internationalPrefixResult =
        Extractor.extractInternationalPrefix(phoneNumber);
    final dialCodeResult = Extractor.extractDialCode(
      internationalPrefixResult.phoneNumber,
    );

    if (dialCodeResult.extracted == null) {
      throw PhoneNumberException(
        code: Code.INVALID_DIAL_CODE,
        description: 'not found',
      );
    }

    return parseWithDialCode(
      dialCodeResult.phoneNumber,
      dialCodeResult.extracted!,
    );
  }

  /// Converts a normalized [nationalNumber] to a [PhoneNumber],
  /// the [PhoneNumber.nsn] is the national number valid internationally
  /// with the leading digits for the region and so on
  static PhoneNumber parseWithDialCode(String nationalNumber, String dialCode) {
    // multiple countries share the same dial code
    final countryResult = Extractor.extractCountry(nationalNumber, dialCode);
    if (countryResult.extracted == null) {
      throw PhoneNumberException(
        code: Code.INVALID_DIAL_CODE,
        description: 'The country could not be guessed',
      );
    }
    return PhoneNumber.fromCountry(
      countryResult.extracted!,
      countryResult.phoneNumber,
      nationalNumber,
    );
  }

  static PhoneNumber parseWithIsoCode(String nationalNumber, String isoCode) {
    final country = Country.fromIsoCode(isoCode);
    final nationalNumberResult =
        Extractor.extractNationalPrefix(nationalNumber, country);
    return PhoneNumber.fromCountry(
      country,
      nationalNumberResult.phoneNumber,
      nationalNumber,
    );
  }
}
