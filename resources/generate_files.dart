import 'dart:io';

import 'package:phone_numbers_parser/src/metadata/models/phone_metadata.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_examples.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_formats.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_lengths.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_patterns.dart';
import 'package:phone_numbers_parser/src/iso_codes/iso_code.dart';

import 'data_sources/read_metadata.dart';
import 'utils/map_builder.dart';
// ignore: avoid_relative_lib_imports
import 'utils/phone_metadata_encoder.dart';

const baseFolder = 'lib/src/metadata/generated';
const isoCodeImport = 'import "../../iso_codes/iso_code.dart";';

void main() async {
  final metadatas = await getMetadata();
  final patterns = await getMetadataPatterns();
  final lengths = await getMetadataLengths();
  final formats = await getMetadataFormats();
  final examples = await getMetadataExamples();

  final countryCodeMap = countryCodeToIsoCodeMap(metadatas);

  await Future.wait([
    writeMetadataMapFile(metadatas),
    writePatternsMapFile(patterns),
    writeLenghtsMapFile(lengths),
    writeFormatsMapFile(formats),
    writeExamplesMapFile(examples),
    writeCountryCodeMap(countryCodeMap),
  ]);
}

Future writeCountryCodeMap(Map<String, List<IsoCode>> countryCodeMap) async {
  var content = '$isoCodeImport'
      'const countryCodeToIsoCode = {%%};';
  var body = '';
  countryCodeMap.forEach((key, value) {
    body += "'$key': [${value.map((v) => "$v").join(',')}],";
  });
  content = content.replaceFirst('%%', body);
  print(content);
  final file = await File('$baseFolder/country_code_to_iso_code.dart')
      .create(recursive: true);
  await file.writeAsString(content);
}

Future writeMetadataMapFile(Map<IsoCode, PhoneMetadata> metadata) async {
  var content = '$isoCodeImport'
      'import "../models/phone_metadata.dart";'
      'const metadataByIsoCode = {%%};';
  var body = '';
  metadata.forEach((key, value) {
    body += '$key: ${encodePhoneMetadata(value)},';
  });
  content = content.replaceFirst('%%', body);
  final file = await File('$baseFolder/metadata_by_iso_code.dart')
      .create(recursive: true);
  await file.writeAsString(content);
}

Future writePatternsMapFile(
    Map<IsoCode, PhoneMetadataPatterns> metadata) async {
  var content = '$isoCodeImport'
      'import "../models/phone_metadata_patterns.dart";'
      'const metadataPatternsByIsoCode = {%%};';
  var body = '';
  metadata.forEach((key, value) {
    body += '$key: ${encodePatterns(value)},';
  });
  content = content.replaceFirst('%%', body);
  final file = await File('$baseFolder/metadata_patterns_by_iso_code.dart')
      .create(recursive: true);
  await file.writeAsString(content);
}

Future writeLenghtsMapFile(Map<IsoCode, PhoneMetadataLengths> metadata) async {
  var content = '$isoCodeImport'
      'import "../models/phone_metadata_lengths.dart";'
      'const metadataLenghtsByIsoCode = {%%};';
  var body = '';
  metadata.forEach((key, value) {
    body += '$key: ${encodeLengths(value)},';
  });
  content = content.replaceFirst('%%', body);
  final file = await File('$baseFolder/metadata_lengths_by_iso_code.dart')
      .create(recursive: true);
  await file.writeAsString(content);
}

Future writeFormatsMapFile(
    Map<IsoCode, PhoneMetadataFormatDefinition> metadata) async {
  var content = '$isoCodeImport'
      'import "../models/phone_metadata_formats.dart";'
      'const metadataFormatsByIsoCode = <IsoCode, PhoneMetadataFormatDefinition>{%%};';
  var body = '';
  metadata.forEach((key, value) {
    body += '$key: ${encodeFormatDefinition(value)},';
  });
  content = content.replaceFirst('%%', body);
  final file = await File('$baseFolder/metadata_formats_by_iso_code.dart')
      .create(recursive: true);
  await file.writeAsString(content);
}

Future writeExamplesMapFile(
    Map<IsoCode, PhoneMetadataExamples> metadata) async {
  var content = '$isoCodeImport'
      'import "../models/phone_metadata_examples.dart";'
      'const metadataExamplesByIsoCode = {%%};';
  var body = '';
  metadata.forEach((key, value) {
    body += '$key: ${encodeExamples(value)},';
  });
  content = content.replaceFirst('%%', body);
  final file = await File('$baseFolder/metadata_examples_by_iso_code.dart')
      .create(recursive: true);
  await file.writeAsString(content);
}
