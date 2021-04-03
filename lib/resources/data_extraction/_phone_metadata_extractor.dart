import 'dart:convert';
import 'dart:io';

import 'package:phone_numbers_parser/src/models/country_phone_description.dart';
import 'package:xml/xml.dart';
import 'package:path/path.dart' as path;
// this file is responsible of extracting the data
// from the phone_number_metadata.xml

/// returns a map like { countryCode: CountryPhoneDescritpion }
Future<Map<String, Map>> getPhoneDescriptionMap() async {
  final phoneNumbersDoc = await _readPhoneNumbersXml();

  return _toPhoneDescriptionsMap(phoneNumbersDoc);
}

Future<XmlDocument> _readPhoneNumbersXml() async {
  final filePath =
      path.join('lib/resources/data_source', 'phone_number_metadata.xml');
  final xmlString = await File(filePath).readAsString();
  return XmlDocument.parse(xmlString);
}

/// from XML doc, we extract the territories that are relevant
Map<String, Map> _toPhoneDescriptionsMap(XmlDocument doc) {
  final territories =
      doc.getElement('phoneNumberMetadata')!.getElement('territories')!;
  // getting all the info we need in this library
  final result = <String, Map>{};
  territories
      .findAllElements('territory')
      // we remove territories that don't have international prefix as they
      // are not relevant to us
      .where(
          (territory) => territory.getAttribute('internationalPrefix') != null)
      // we remove territories that don't have mobile metadata as they are most likely not relevant
      // to most applications
      .where((territory) => territory.getElement('mobile') != null)
      .forEach((territory) => result[territory.getAttribute('id')!] =
          _extractCountryPhoneDescription(territory));

  return result;
}

/// from each territory, we extract the relevant data
Map _extractCountryPhoneDescription(XmlElement territory) {
  try {
    // phone validation data
    final validation = _extractPhoneValidation(territory);

    // CountryPhoneDescription data
    final dialCode = territory.getAttribute('countryCode')!;
    final internationalPrefix = territory.getAttribute('internationalPrefix')!;
    final isMainCountryForDialCode =
        territory.getAttribute('mainCountryForCode') == 'true';
    // we will use the national prefix for parsing if there is any
    var nationalPrefix = territory.getAttribute('nationalPrefixForParsing');
    nationalPrefix ??= territory.getAttribute('nationalPrefix');
    final nationalPrefixTransformRule =
        territory.getAttribute('nationalPrefixTransformRule');

    return {
      'dialCode': dialCode,
      'internationalPrefix': parsePattern(internationalPrefix),
      'isMainCountryForDialCode': isMainCountryForDialCode,
      'nationalPrefix':
          nationalPrefix == null ? null : parsePattern(nationalPrefix),
      'nationalPrefixTransformRule': nationalPrefixTransformRule == null
          ? null
          : parsePattern(nationalPrefixTransformRule),
      'validation': validation,
    };
  } catch (e) {
    print(territory);
    rethrow;
  }
}

Map _extractPhoneValidation(XmlElement territory) {
  final general =
      _extractPhoneValidationRules(territory.getElement('generalDesc')!);
  final mobile = _extractPhoneValidationRules(territory.getElement('mobile')!);
  final fixedLine =
      _extractPhoneValidationRules(territory.getElement('fixedLine')!);
  return {
    'general': general,
    'mobile': mobile,
    'fixedLine': fixedLine,
  };
}

Map _extractPhoneValidationRules(XmlElement element) {
  final patternUnparsed =
      element.getElement('nationalNumberPattern')!.innerText;

  final pattern = parsePattern(patternUnparsed);
  final lengthsUnparsed =
      element.getElement('possibleLengths')?.getAttribute('national');
  final lengths =
      lengthsUnparsed != null ? _parsePossibleLengths(lengthsUnparsed) : null;
  return {'pattern': pattern, 'lengths': lengths};
}

/// the patterns in the xml are weirdly formatted
String parsePattern(String pattern) {
  return pattern.replaceAll(' ', '').replaceAll('\r', '').replaceAll('\n', '');
}

/// Parse lengths string into array of Int, e.g. "6,[8-10]" becomes [6,8,9,10]
List<int> _parsePossibleLengths(String lengths) {
  final components = lengths.split(',');
  final result = <int>[];
  components.forEach((c) => result.addAll(_parseLengthComponent(c)));

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
