import 'dart:io';

import 'package:phone_numbers_parser/src/models/country_phone_description.dart';
import 'package:xml/xml.dart';
// this file is responsible of extracting the data
// from the phone_number_metadata.xml

/// returns a map like { countryCode: CountryPhoneDescritpion }
Future<Map<String, CountryPhoneDescription>> getPhoneDescriptionMap() async {
  final doc = await _readPhoneNumbersXml();
  final territories = _getTerritories(doc);
  return _toPhoneDescriptions(territories);
}

Future<XmlDocument> _readPhoneNumbersXml() async {
  final filePath = 'resources/original/data_source/phone_number_metadata.xml';
  final xmlString = await File(filePath).readAsString();
  return XmlDocument.parse(xmlString);
}

List<XmlElement> _getTerritories(XmlDocument doc) {
  final territories =
      doc.getElement('phoneNumberMetadata')!.getElement('territories')!;
  return territories
      .findAllElements('territory')
      // we remove territories that don't have international prefix as they
      // are not relevant to us
      .where(
          (territory) => territory.getAttribute('internationalPrefix') != null)
      .where((territory) => territory.getElement('mobile') != null)
      .toList();
}

/// from XML doc, we extract the territories that are relevant
Map<String, CountryPhoneDescription> _toPhoneDescriptions(
  List<XmlElement> territories,
) {
  final result = <String, CountryPhoneDescription>{};
  territories.forEach((territory) => result[territory.getAttribute('id')!] =
      _extractCountryPhoneDescription(territory));

  return result;
}

/// from each territory, we extract the relevant data
CountryPhoneDescription _extractCountryPhoneDescription(XmlElement territory) {
  try {
    final attr = territory.getAttribute;
    final maybeParseAttr = (String attrName) {
      final value = attr(attrName);
      return value == null ? null : parsePattern(value);
    };
    return CountryPhoneDescription(
      dialCode: attr('countryCode')!,
      internationalPrefix: maybeParseAttr('internationalPrefix')!,
      isMainCountryForDialCode: attr('mainCountryForCode') == 'true',
      leadingDigits: attr('leadingDigits'),
      nationalPrefix: maybeParseAttr('nationalPrefix'),
      nationalPrefixForParsing: maybeParseAttr('nationalPrefixForParsing'),
      nationalPrefixTransformRule: attr('nationalPrefixTransformRule'),
      validation: _extractPhoneValidation(territory),
    );
  } catch (e) {
    print(territory);
    rethrow;
  }
}

PhoneValidation _extractPhoneValidation(XmlElement territory) {
  final elem = territory.getElement;
  return PhoneValidation(
    general: _extractPhoneValidationRules(elem('generalDesc')!),
    mobile: _extractPhoneValidationRules(elem('mobile')!),
    fixedLine: _extractPhoneValidationRules(elem('fixedLine')!),
  );
}

PhoneValidationRules _extractPhoneValidationRules(XmlElement element) {
  final patternUnparsed =
      element.getElement('nationalNumberPattern')!.innerText;

  final pattern = parsePattern(patternUnparsed);
  final lengthsUnparsed =
      element.getElement('possibleLengths')?.getAttribute('national');
  final lengths =
      lengthsUnparsed != null ? _parsePossibleLengths(lengthsUnparsed) : [];
  return PhoneValidationRules(
    pattern: pattern,
    lengths: lengths as List<int>,
  );
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
