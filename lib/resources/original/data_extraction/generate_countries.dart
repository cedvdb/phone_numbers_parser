import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/country_phone_description.dart';

List<Country> generateCountries(
  Map<String, String> names,
  Map<String, CountryPhoneDescription> phoneDescriptions,
) {
  return phoneDescriptions.entries
      // phone_metadata is (imo) overly precise by including territories
      // like islands with 9 families where each individual has 2 cows and 2 sheeps.
      // It is assumed here that those regions aren't needed for simplicity.
      // Note: that island is Tristan de cuhan and its story is interresting.
      .where((entry) {
        if (names[entry.key] != null) {
          return true;
        } else {
          print('${entry.key} skipped');
          return false;
        }
      })
      .map(
        (entry) => Country(
          name: names[entry.key]!,
          flag: _generateFlagEmojiUnicode(entry.key),
          isoCode: entry.key,
          phone: entry.value,
        ),
      )
      .toList();
}

/// Returns a [String] which will be the unicode of a Flag Emoji,
/// from a country [isoCode] passed as a parameter.
String _generateFlagEmojiUnicode(String isoCode) {
  final base = 127397;
  return isoCode.codeUnits
      .map((e) => String.fromCharCode(base + e))
      .toList()
      .reduce((value, element) => value + element)
      .toString();
}
