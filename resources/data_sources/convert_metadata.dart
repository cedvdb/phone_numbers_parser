import 'dart:convert';
import 'dart:io';

import 'xml_to_json.dart';

void main() async {
  await convertXMLToJson();
  await convertPhoneNumberMetadata();
}

/// reads the phone number metadata from the ios library phoneNumberKit
/// and applies some changes to it to make it fit the naming here
Future convertPhoneNumberMetadata() async {
  final inputFile =
      'resources/data_sources/original_phone_number_metadata.json';
  final outputFile = 'resources/data_sources/parsed_phone_number_metadata.json';
  final jsonString = await File(inputFile).readAsString();
  Map<String, dynamic> metadata = jsonDecode(jsonString);
  // remove unnecessary nesting in metadata
  List territories =
      metadata['phoneNumberMetadata']['territories']['territory'];
  // remove places that have no fixedLine because those are not geographical regions
  territories = territories.where((t) => t['fixedLine'] != null).toList();
  // make the isoCode the key for metadata, and parse metadata
  final converted = {for (var e in territories) e['id']: convertTerritory(e)};

  return File(outputFile).writeAsString(jsonEncode(converted));
}

Map convertTerritory(Map<String, dynamic> territory) {
  final voip = territory['voip'];
  final tollFree = territory['tollFree'];
  final premiumRate = territory['premiumRate'];
  final sharedCost = territory['sharedCost'];
  final personalNumber = territory['personalNumber'];
  final uan = territory['uan'];
  final pager = territory['pager'];
  final voiceMail = territory['voiceMail'];
  return {
    'isoCode': territory['id'],
    'countryCode': territory['countryCode'],
    'internationalPrefix': territory['internationalPrefix'],
    'nationalPrefix': territory['nationalPrefix'],
    'leadingDigits': territory['leadingDigits'],
    'isMainCountryForDialCode': territory['mainCountryForCode'] == 'true',
    'lengths': {
      'general': getPossibleLengths(territory['generalDesc']),
      'fixedLine': getPossibleLengths(territory['fixedLine']),
      // there is one island with 800 people on it that does not have mobile phones,
      // fixedLine is used for that island. It is called Tristan de Cuhan. They are worth
      // a read on wikipedia
      'mobile':
          getPossibleLengths(territory['mobile'] ?? territory['fixedLine']),
      if (voip != null) 'voip': getPossibleLengths(voip),
      if (tollFree != null) 'tollFree': getPossibleLengths(tollFree),
      if (premiumRate != null) 'premiumRate': getPossibleLengths(premiumRate),
      if (sharedCost != null) 'sharedCost': getPossibleLengths(sharedCost),
      if (personalNumber != null)
        'personalNumber': getPossibleLengths(personalNumber),
      if (uan != null) 'uan': getPossibleLengths(uan),
      if (pager != null) 'pager': getPossibleLengths(pager),
      if (voiceMail != null) 'voiceMail': getPossibleLengths(voiceMail),
    },
    'patterns': {
      'nationalPrefixForParsing': territory['nationalPrefixForParsing'],
      'nationalPrefixTransformRule': territory['nationalPrefixTransformRule'],
      'general': getPattern(territory['generalDesc']),
      'fixedLine': getPattern(territory['fixedLine']),
      // see comment on lengths
      'mobile': getPattern(territory['mobile'] ?? territory['fixedLine']),
      if (voip != null) 'voip': getPattern(voip),
      if (tollFree != null) 'tollFree': getPattern(tollFree),
      if (premiumRate != null) 'premiumRate': getPattern(premiumRate),
      if (sharedCost != null) 'sharedCost': getPattern(sharedCost),
      if (personalNumber != null) 'personalNumber': getPattern(personalNumber),
      if (uan != null) 'uan': getPattern(uan),
      if (pager != null) 'pager': getPattern(pager),
      if (voiceMail != null) 'voiceMail': getPattern(voiceMail),
    },
    'examples': {
      'fixedLine': territory['fixedLine']['exampleNumber'],
      // see comment on lengths
      'mobile':
          (territory['mobile'] ?? territory['fixedLine'])['exampleNumber'],
      if (voip != null) 'voip': voip['exampleNumber'],
      if (tollFree != null) 'tollFree': tollFree['exampleNumber'],
      if (premiumRate != null) 'premiumRate': premiumRate['exampleNumber'],
      if (sharedCost != null) 'sharedCost': sharedCost['exampleNumber'],
      if (personalNumber != null)
        'personalNumber': personalNumber['exampleNumber'],
      if (uan != null) 'uan': uan['exampleNumber'],
      if (pager != null) 'pager': pager['exampleNumber'],
      if (voiceMail != null) 'voiceMail': voiceMail['exampleNumber'],
    },
    'formats': getFormats(territory['availableFormats']?['numberFormat']),
  };
}

List<int> getPossibleLengths(Map<String, dynamic> validation) {
  var lengths = validation['possibleLengths'];
  print(lengths);
  lengths = lengths?['national'];
  return _parsePossibleLengths(lengths);
}

String getPattern(Map<String, dynamic> validation) {
  return validation['nationalNumberPattern'];
}

/// fixes a few inconsistencies in format
List getFormats(dynamic formats) {
  List asArray;
  if (formats is Map) {
    asArray = [formats];
  } else if (formats == null) {
    asArray = [];
  } else {
    asArray = formats;
  }

  for (var element in asArray) {
    if (element['leadingDigits'] is! List) {
      element['leadingDigits'] = [element['leadingDigits']];
    }
  }
  return asArray;
}

/// Parse lengths string into array of Int, e.g. "6,[8-10]" becomes [6,8,9,10]
List<int> _parsePossibleLengths(String? lengths) {
  if (lengths == null) return [];
  final components = lengths.split(',');
  final result = <int>[];
  for (var c in components) {
    result.addAll(_parseLengthComponent(c));
  }

  return result;
}

/// Parses numbers and ranges into array of Int
List<int> _parseLengthComponent(String component) {
  final parsed = int.tryParse(component);
  if (parsed != null) return [parsed];

  final trimmedComponent = component.replaceAll('[', '').replaceAll(']', '');
  final rangeLimits = trimmedComponent.split('-').map((e) => int.parse(e));

  if (rangeLimits.length != 2) {
    throw 'possible length range is not what was expected';
  }

  final result = <int>[];
  for (var i = rangeLimits.first; i <= rangeLimits.last; i++) {
    result.add(i);
  }
  return result;
}
