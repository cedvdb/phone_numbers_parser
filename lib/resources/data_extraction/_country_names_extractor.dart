import 'dart:convert';
import 'dart:io';

// this file is responsible of extracting the data from the country_names.json

/// returns a map of { countryCode: countryName }
Future<Map<String, String>> getCountryNamesMap() async {
  final countryNames = await _readCountryNameJson();
  return countryNames.fold<Map<String, String>>(
    <String, String>{},
    (prev, curr) => prev[curr['code']] = curr['name'],
  );
}

/// reads the json file of country names which is an array of country information
Future<List<Map<String, dynamic>>> _readCountryNameJson() async {
  final jsonString = await File('country_names.json').readAsString();
  return jsonDecode(jsonString) as List<Map<String, dynamic>>;
}
