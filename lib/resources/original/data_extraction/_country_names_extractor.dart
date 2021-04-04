import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
// this file is responsible of extracting the data from the country_names.json

/// returns a map of { countryCode: countryName }
Future<Map<String, String>> getCountryNamesMap() async {
  final countryNames = await _readCountryNameJson();
  final result = <String, String>{};
  countryNames.forEach(
      (countryName) => result[countryName['code']] = countryName['name']);
  return result;
}

/// reads the json file of country names which is an array of country information
Future<List<dynamic>> _readCountryNameJson() async {
  final filePath =
      path.join('lib/resources/original/data_source', 'country_names.json');
  final jsonString = await File(filePath).readAsString();
  return jsonDecode(jsonString);
}
