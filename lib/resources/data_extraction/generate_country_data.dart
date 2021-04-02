// This file is responsile of grouping up the data we got
// from country_names.json and phone_number_metadata.xml

import 'package:phone_numbers_parser/resources/data_extraction/_country_names_extractor.dart';
import 'package:phone_numbers_parser/resources/data_extraction/_phone_metadata_extractor.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/country_phone_description.dart';

class ExtractedCountryData {
  final List<Country> countries;
  final Map<String, Country> countriesByIsoCode;
  final Map<String, List<Country>> countriesByDialCode;

  ExtractedCountryData(
    this.countries,
    this.countriesByIsoCode,
    this.countriesByDialCode,
  );
}

Future<ExtractedCountryData> getExtractedCountryData() async {
  final names = await getCountryNamesMap();
  final phoneDescriptions = await getPhoneDescriptionMap();
  final countries = _generateCountries(names, phoneDescriptions);
  final countriesByIsoCode = _toIsoCodeMap(countries);
  final countriesByDialCode = _toDialCodeMap(countries);
  return ExtractedCountryData(
    countries,
    countriesByIsoCode,
    countriesByDialCode,
  );
}

List<Country> _generateCountries(
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

/// given a list of countries we make a map to access them by isoCode
Map<String, Country> _toIsoCodeMap(List<Country> countries) {
  final map = <String, Country>{};
  countries.forEach((element) {
    if (map[element.isoCode] != null) {
      throw 'duplicated country code';
    }
    map[element.isoCode] = element;
  });
  return map;
}

Map<String, List<Country>> _toDialCodeMap(List<Country> countries) {
  final map = <String, List<Country>>{};
  countries.forEach((element) {
    if (map[element.dialCode] == null) {
      map[element.dialCode] = [];
    }
    // we insert the main country at the start of the array so it's easy to find
    if (element.phone.isMainCountryForDialCode == true) {
      map[element.dialCode]!.insert(0, element);
    } else {
      map[element.dialCode]!.add(element);
    }
  });
  return map;
}
