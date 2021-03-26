import 'dart:io';

import 'package:xml/xml.dart';

import '../country.dart';

Future getDartDataFromXml() async {
  final doc = await readXml();
  // creating the data, some of those functions can modify the data as to
  // have a dataset that fits our needs better (addMainCountryData does)
  final _countries = toCountries(doc);
  final _byIsoCode = toIsoCodeMap(_countries);
  final _byDialCode = toDialCodeMap(_countries);
  addMainCountryData(_byDialCode);
  // here the data for each country should be set and we can transform each
  // ModifiableCountry to a final country version
  final countries = _countries.map((e) => e.toCountry()).toList();
  final byIsoCode =
      _byIsoCode.map((key, value) => MapEntry(key, value.toCountry()));
  final byDialCode = _byDialCode
      .map((key, value) => MapEntry(key, value.map((c) => c.toCountry())));
  return null;
}

class CountriesData {
  List<Country> countries;
  Map<String, List<Country>> byIsoCode;
  Map<String, List<>> byDialCode;
}

// modifiable versions of country and mobile
class ModifiableCountry {
  String? isoCode;
  String? dialCode;
  Mobile? mobile;
  String? internationalPrefix;
  String? nationalPrefix;
  bool? isMainCountryForIsoCode;

  ModifiableCountry();

  Country toCountry() => Country(
        isoCode: isoCode!,
        dialCode: dialCode!,
        internationalPrefix: internationalPrefix!,
        nationalPrefix: nationalPrefix,
        isMainCountryForIsoCode: isMainCountryForIsoCode!,
        mobile: mobile!,
      );
}

Future<XmlDocument> readXml() async {
  final xmlString = await File('phone_number_metadata.xml').readAsString();
  return XmlDocument.parse(xmlString);
}

/// from XML doc, we extract the territories that are relevant
List<ModifiableCountry> toCountries(XmlDocument doc) {
  final territories =
      doc.getElement('phoneNumberMetadata')!.getElement('territories')!;
  // getting all the info we need in this library
  final countries = territories
      .findAllElements('territory')
      // we remove territories that don't have international prefix as they
      // are not relevant to us
      .where((territory) => territory.getElement('internationalPrefix') != null)
      // we remove territories that don't have mobile metadata (usually the same as above)
      .where((territory) => territory.getElement('mobile') != null)
      .map(_extractCountryData);

  return countries.toList();
}

/// from each territory, we extract the relevant data
ModifiableCountry _extractCountryData(XmlElement territory) {
  try {
    final country = ModifiableCountry();
    country.isoCode = territory.getAttribute('id')!;
    country.dialCode = territory.getAttribute('countryCode')!;
    country.isMainCountryForIsoCode =
        territory.getAttribute('mainCountryForCode') == 'true';
    country.internationalPrefix = territory.getAttribute('internationalPrefix');
    country.nationalPrefix = territory.getAttribute('nationalPrefix');

    final mobileElem = territory.getElement('mobile');
    if (mobileElem == null) return country;

    final mobileLengths =
        mobileElem.getElement('possibleLengths')!.getAttribute('national')!;
    final mobilePattern = mobileElem
        .getElement('nationalNumberPattern')!
        .text
        .replaceAll(' ', '')
        .replaceAll('\r', '')
        .replaceAll('\n', '');
    country.mobile = Mobile(lengths: mobileLengths, pattern: mobilePattern);
    return country;
  } catch (e) {
    print(territory);
    rethrow;
  }
}

/// given a lit of countries we make a map to access them by isoCode
Map<String, ModifiableCountry> toIsoCodeMap(List<ModifiableCountry> countries) {
  final map = <String, ModifiableCountry>{};
  countries.forEach((element) {
    if (map[element.isoCode!] != null) {
      throw 'duplicated country code';
    }
    map[element.isoCode!] = element;
  });
  return map;
}

Map<String, List<ModifiableCountry>> toDialCodeMap(
    List<ModifiableCountry> countries) {
  final map = <String, List<ModifiableCountry>>{};
  countries.forEach((element) {
    if (map[element.dialCode] == null) {
      map[element.dialCode!] = [];
    }
    map[element.dialCode]!.add(element);
  });
  return map;
}

// adds the isMainCountryForDialCode that is implied
void addMainCountryData(Map<String, List<ModifiableCountry>> byDialCode) {
  byDialCode.values.forEach((oneDialCode) {
    if (oneDialCode.length == 1) {
      oneDialCode[0].isMainCountryForIsoCode = true;
    } else {
      final mainCountryIndex = oneDialCode
          .indexWhere((country) => country.isMainCountryForIsoCode == true);
      if (mainCountryIndex < 0) {
        throw 'No main country for dial code';
      }
      oneDialCode.forEach((country) => country.isMainCountryForIsoCode = false);
      oneDialCode[mainCountryIndex].isMainCountryForIsoCode = true;
    }
  });
}
