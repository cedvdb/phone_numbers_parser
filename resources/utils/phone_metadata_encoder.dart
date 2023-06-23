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
    )''';
}

String encodeLengths(PhoneMetadataLengths lengths) {
  return '''PhoneMetadataLengths(
      general: ${_enc(lengths.general)}, 
      mobile: ${_enc(lengths.mobile)}, 
      fixedLine: ${_enc(lengths.fixedLine)}, 
    )''';
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
    )''';
}

String _enc(v) {
  if (v is String) return 'r"$v"';
  if (v == null) return 'null';
  return jsonEncode(v);
}
