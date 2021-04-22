// we are going to take a base file and replace tokens with values that we
// extracted from the data source

import 'dart:convert';
import 'dart:io';

import './countries_converter.dart';
import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/models/country_phone_description.dart';

const String DATA_TOKEN = '// data here';
const String COMMENT_TOKEN = '// comment here';
final String comment = '// This file was auto generated';
final String INPUT_PATH = 'resources/file_generation';
final String BASE_COUNTRY_LIST = '$INPUT_PATH/base_country_list.dart';
final String BASE_COUNTRY_BY_ISO_CODE =
    '$INPUT_PATH/base_country_by_iso_code.dart';
final String BASE_COUNTRY_BY_DIAL_CODE =
    '$INPUT_PATH/base_country_by_dial_code.dart';
final String OUTPUT_PATH = 'lib/src/generated';
final String OUTPUT_LIST = '$OUTPUT_PATH/country_list.dart';
final String OUTPUT_BY_DIAL_CODE =
    '$OUTPUT_PATH/countries_by_dial_code_map.dart';
final String OUTPUT_BY_ISO_CODE = '$OUTPUT_PATH/countries_by_iso_code_map.dart';

void main() async {
  final countries = await getCountries();
  await createList(countries);
  await createByIsoCode(toIsoCodeMap(countries));
  await createByDialCode(toDialCodeMap(countries));
}

Future createList(List<Country> countries) async {
  final baseContent = await File(BASE_COUNTRY_LIST).readAsString();
  final dataOutput = getCountryListString(countries);
  final output = baseContent.replaceFirst(COMMENT_TOKEN, comment).replaceFirst(
        DATA_TOKEN,
        dataOutput,
      );
  return File(OUTPUT_LIST).writeAsString(output);
}

Future createByIsoCode(Map<String, Country> byIsoCode) async {
  final baseContent = await File(BASE_COUNTRY_BY_ISO_CODE).readAsString();
  final dataOutput = byIsoCode.entries.fold<String>(
      '', (a, b) => a + '"${b.key}": ' + countryString(b.value) + ',\n');
  final output = baseContent.replaceFirst(COMMENT_TOKEN, comment).replaceFirst(
        DATA_TOKEN,
        dataOutput,
      );
  return File(OUTPUT_BY_ISO_CODE).writeAsString(output);
}

Future createByDialCode(Map<String, List<Country>> byDialCode) async {
  final baseContent = await File(BASE_COUNTRY_BY_DIAL_CODE).readAsString();
  final dataOutput = byDialCode.entries.fold<String>('',
      (a, b) => a + '"${b.key}": [' + getCountryListString(b.value) + '],\n');
  final output = baseContent.replaceFirst(COMMENT_TOKEN, comment).replaceFirst(
        DATA_TOKEN,
        dataOutput,
      );
  return File(OUTPUT_BY_DIAL_CODE).writeAsString(output);
}

String getCountryListString(List<Country> countries) {
  return countries.fold<String>('', (a, b) => a + countryString(b) + ',\n');
}

String countryString(Country country) {
  // this is a bit verbose but it's to have constants
  return '''const Country(
  name: ${enc(country.name)}, 
  flag: ${enc(country.flag)}, 
  isoCode: ${enc(country.isoCode)}, 
  phoneDescription: ${phoneDescriptionString(country.phoneDescription)}, 
  )''';
}

String phoneDescriptionString(CountryPhoneDescription desc) {
  return '''CountryPhoneDescription(
      dialCode: ${enc(desc.dialCode)}, 
      leadingDigits: ${enc(desc.leadingDigits)},
      internationalPrefix: ${enc(desc.internationalPrefix)}, 
      nationalPrefix: ${enc(desc.nationalPrefix)},
      nationalPrefixForParsing: ${enc(desc.nationalPrefixForParsing)},
      nationalPrefixTransformRule: ${enc(desc.nationalPrefixTransformRule)},
      isMainCountryForDialCode: ${enc(desc.isMainCountryForDialCode)},
      validation: ${phoneValidationString(desc.validation)},
    )''';
}

String phoneValidationString(PhoneValidation v) {
  return '''PhoneValidation(
        general: ${phoneValidationRulesString(v.general)}, 
        mobile: ${phoneValidationRulesString(v.mobile)}, 
        fixedLine: ${phoneValidationRulesString(v.fixedLine)}, 
      )''';
}

String phoneValidationRulesString(PhoneValidationRules r) {
  return '''PhoneValidationRules(lengths: ${enc(r.lengths)}, pattern: ${enc(r.pattern)},)''';
}

String enc(v) {
  if (v is String) return 'r"$v"';
  if (v == null) return 'null';
  return jsonEncode(v);
}
