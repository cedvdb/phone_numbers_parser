// This file is responsile of grouping up the data we got
// from country_names.json and phone_number_metadata.xml

import 'package:phone_numbers_parser/resources/data_extraction/_country_names_extractor.dart';
import 'package:phone_numbers_parser/resources/data_extraction/_phone_metadata_extractor.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/phone_description.dart';

void main() async {
  final names = await getCountryNamesMap();
  final phoneDescriptions = await getPhoneDescriptionMap();
}

generateCountries(
  Map<String, String> names,
  Map<String, CountryPhoneDescription> phonedescription,
) {
  phonedescription.entries
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
  }).map(
    (entry) => Country(
      name: names[entry.key]!,
      flag: flag,
      isoCode: entry.key,
      phone: entry.value,
    ),
  );
}
