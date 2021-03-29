import 'dart:io';

import 'package:phone_numbers_parser/src/models/phone_description.dart';
import 'package:xml/xml.dart';

// this file is responsible of extracting the data
// from the phone_number_metadata.xml

/// returns a map like { countryCode: CountryPhoneDescritpion }
Future<Map<String, CountryPhoneDescription>> getPhoneDescriptionMap() async {
  final phoneNumbersDoc = await _readPhoneNumbersXml();

  return _toPhoneDescriptions(phoneNumbersDoc);
}

Future<XmlDocument> _readPhoneNumbersXml() async {
  final xmlString = await File('phone_number_metadata.xml').readAsString();
  return XmlDocument.parse(xmlString);
}

/// from XML doc, we extract the territories that are relevant
Map<String, CountryPhoneDescription> _toPhoneDescriptions(XmlDocument doc) {
  final territories =
      doc.getElement('phoneNumberMetadata')!.getElement('territories')!;
  // getting all the info we need in this library
  final result = <String, CountryPhoneDescription>{};
  territories
      .findAllElements('territory')
      // we remove territories that don't have international prefix as they
      // are not relevant to us
      .where((territory) => territory.getElement('internationalPrefix') != null)
      // we remove territories that don't have mobile metadata as they are most likely not relevant
      // to most applications
      .where((territory) => territory.getElement('mobile') != null)
      .forEach(
        (territory) => result[territory.getAttribute('id')!] =
            _extractCountryPhoneDescription(territory),
      );

  return result;
}

/// from each territory, we extract the relevant data
CountryPhoneDescription _extractCountryPhoneDescription(XmlElement territory) {
  try {
    // phone validation data
    final validation = _extractPhoneValidation(territory);

    // CountryPhoneDescription data
    final dialCode = territory.getAttribute('countryCode')!;
    final internationalPrefix = territory.getAttribute('internationalPrefix')!;
    final isMainCountryForDialCode =
        territory.getAttribute('mainCountryForCode') == 'true';
    final nationalPrefix = territory.getAttribute('nationalPrefix');
    final nationalPrefixForParsing =
        territory.getAttribute('nationalPrefixForParsing');
    final nationalPrefixTransformRule =
        territory.getAttribute('nationalPrefixTransformRule');

    return CountryPhoneDescription(
      dialCode: dialCode,
      internationalPrefix: internationalPrefix,
      validation: validation,
      isMainCountryForDialCode: isMainCountryForDialCode,
      nationalPrefix: nationalPrefixForParsing ?? nationalPrefix,
      nationalPrefixTransformRule: nationalPrefixTransformRule,
    );
  } catch (e) {
    print(territory);
    rethrow;
  }
}

PhoneValidation _extractPhoneValidation(XmlElement territory) {
  final general =
      _extractPhoneValidationRules(territory.getElement('generalDesc')!);
  final mobile = _extractPhoneValidationRules(territory.getElement('mobile')!);
  final fixedLine =
      _extractPhoneValidationRules(territory.getElement('fixedLine')!);
  return PhoneValidation(
    general: general,
    mobile: mobile,
    fixedLine: fixedLine,
  );
}

PhoneValidationRules _extractPhoneValidationRules(XmlElement element) {
  final pattern = element
      .getElement('nationalNumberPattern')!
      .innerText
      .replaceAll('\s', '');
  final lengthsUnparsed =
      element.getElement('possibleLengths')?.getAttribute('national');
  final lengths =
      lengthsUnparsed != null ? _parsePossibleLengths(lengthsUnparsed) : null;
  return PhoneValidationRules(pattern: pattern, lengths: lengths);
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

  final trimmedComponent = component.replaceAll('\[\]', '');
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

// /// given a lit of countries we make a map to access them by isoCode
// Map<String, ModifiableCountry> toIsoCodeMap(List<ModifiableCountry> countries) {
//   final map = <String, ModifiableCountry>{};
//   countries.forEach((element) {
//     if (map[element.isoCode!] != null) {
//       throw 'duplicated country code';
//     }
//     map[element.isoCode!] = element;
//   });
//   return map;
// }

// Map<String, List<ModifiableCountry>> toDialCodeMap(
//     List<ModifiableCountry> countries) {
//   final map = <String, List<ModifiableCountry>>{};
//   countries.forEach((element) {
//     if (map[element.dialCode] == null) {
//       map[element.dialCode!] = [];
//     }
//     map[element.dialCode]!.add(element);
//   });
//   return map;
// }

// // adds the isMainCountryForDialCode that is implied
// void addMainCountryData(Map<String, List<ModifiableCountry>> byDialCode) {
//   byDialCode.values.forEach((oneDialCode) {
//     if (oneDialCode.length == 1) {
//       oneDialCode[0].isMainCountryForDialCode = true;
//     } else {
//       final mainCountryIndex = oneDialCode
//           .indexWhere((country) => country.isMainCountryForDialCode == true);
//       if (mainCountryIndex < 0) {
//         throw 'No main country for dial code';
//       }
//       oneDialCode
//           .forEach((country) => country.isMainCountryForDialCode = false);
//       oneDialCode[mainCountryIndex].isMainCountryForDialCode = true;
//     }
//   });
// }
