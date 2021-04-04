import 'dart:convert';
import 'dart:io';

import 'package:phone_numbers_parser/src/models/country.dart';

Future<List<Country>> getCountries() async {
  final jsonStr = await File('lib/resources/countries.json').readAsString();
  List<dynamic> decoded = jsonDecode(jsonStr);
  return decoded.map((map) => Country.fromMap(map)).toList();
}

/// given a list of countries we make a map to access them by isoCode
Map<String, Country> toIsoCodeMap(List<Country> countries) {
  final map = <String, Country>{};
  countries.forEach((element) {
    if (map[element.isoCode] != null) {
      throw 'duplicated country code';
    }
    map[element.isoCode] = element;
  });
  return map;
}

Map<String, List<Country>> toDialCodeMap(List<Country> countries) {
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
