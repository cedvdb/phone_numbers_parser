// This file is responsile of grouping up the data we got
// from country_names.json and phone_number_metadata.xml

import 'dart:convert';
import 'dart:io';

import './data_extraction/_country_names_extractor.dart';
import './data_extraction/_phone_metadata_extractor.dart';
import 'data_extraction/generate_countries.dart';

void main() async {
  final names = await getCountryNamesMap();
  final phoneDescriptions = await getPhoneDescriptionMap();
  final countries = generateCountries(names, phoneDescriptions);
  final encoder = JsonEncoder.withIndent('  ');
  await File('resources/countries.json')
      .writeAsString(encoder.convert(countries.map((c) => c.toMap()).toList()));
}
