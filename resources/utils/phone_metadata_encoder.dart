import 'dart:convert';

import 'package:phone_numbers_parser/src/metadata/models/phone_metadata.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_examples.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_formats.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_lengths.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_patterns.dart';

String encodePhoneMetadata(PhoneMetadata metadata) {
  return '''PhoneMetadata(
      countryCode: ${_enc(metadata.countryCode)}, 
      isoCode: ${metadata.isoCode},
      leadingDigits: ${_enc(metadata.leadingDigits)},
      internationalPrefix: ${_enc(metadata.internationalPrefix)}, 
      nationalPrefix: ${_enc(metadata.nationalPrefix)},
      isMainCountryForDialCode: ${_enc(metadata.isMainCountryForDialCode)},
    )''';
}

String encodePatterns(PhoneMetadataPatterns metadata) {
  return '''PhoneMetadataPatterns(
      nationalPrefixForParsing: ${_enc(metadata.nationalPrefixForParsing)},
      nationalPrefixTransformRule: ${_enc(metadata.nationalPrefixTransformRule)},
      general: ${_enc(metadata.general)}, 
      mobile: ${_enc(metadata.mobile)}, 
      fixedLine: ${_enc(metadata.fixedLine)}, 
      voip: ${_enc(metadata.voip)}, 
      tollFree: ${_enc(metadata.tollFree)},
      premiumRate: ${_enc(metadata.premiumRate)},
      sharedCost: ${_enc(metadata.sharedCost)},
      personalNumber: ${_enc(metadata.personalNumber)},
      uan: ${_enc(metadata.uan)},
      pager: ${_enc(metadata.pager)},
      voiceMail: ${_enc(metadata.voiceMail)},
    )''';
}

String encodeLengths(PhoneMetadataLengths lengths) {
  return '''PhoneMetadataLengths(
      general: ${_enc(lengths.general)}, 
      mobile: ${_enc(lengths.mobile)}, 
      fixedLine: ${_enc(lengths.fixedLine)}, 
      voip: ${_enc(lengths.voip)}, 
      tollFree: ${_enc(lengths.tollFree)},
      premiumRate: ${_enc(lengths.premiumRate)},
      sharedCost: ${_enc(lengths.sharedCost)},
      personalNumber: ${_enc(lengths.personalNumber)},
      uan: ${_enc(lengths.uan)},
      pager: ${_enc(lengths.pager)},
      voiceMail: ${_enc(lengths.voiceMail)},
    )''';
}

String encodeFormatDefinition(PhoneMetadataFormatDefinition definition) {
  if (definition is PhoneMetadataFormatReferenceDefinition) {
    return '''PhoneMetadataFormatReferenceDefinition(
      referenceIsoCode: ${definition.referenceIsoCode},
    )''';
  } else if (definition is PhoneMetadataFormatListDefinition) {
    return '''PhoneMetadataFormatListDefinition(
      formats: [${definition.formats.map(encodeFormats).join(', ')}],
    )''';
  }
  throw ArgumentError('Unknown definition type: $definition');
}

String encodeFormats(PhoneMetadataFormat formats) {
  return '''PhoneMetadataFormat(
      pattern: ${_enc(formats.pattern)},
      nationalPrefixFormattingRule: ${_enc(formats.nationalPrefixFormattingRule)},
      leadingDigits: ${_enc(formats.leadingDigits)},
      format: ${_enc(formats.format)},
      intlFormat: ${_enc(formats.intlFormat)},
    )''';
}

String encodeExamples(PhoneMetadataExamples examples) {
  return '''PhoneMetadataExamples(
      fixedLine: ${_enc(examples.fixedLine)},
      mobile: ${_enc(examples.mobile)},
      voip: ${_enc(examples.voip)},
      tollFree: ${_enc(examples.tollFree)},
      premiumRate: ${_enc(examples.premiumRate)},
      sharedCost: ${_enc(examples.sharedCost)},
      personalNumber: ${_enc(examples.personalNumber)},
      uan: ${_enc(examples.uan)},
      pager: ${_enc(examples.pager)},
      voiceMail: ${_enc(examples.voiceMail)},
    )''';
}

String _enc(v) {
  if (v is String) return 'r"$v"';
  if (v == null) return 'null';
  return jsonEncode(v);
}
