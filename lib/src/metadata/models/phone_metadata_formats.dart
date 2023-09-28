import 'dart:convert';

typedef PhoneMetadataFormats = List<PhoneMetadataFormat>;

class PhoneMetadataFormat {
  final String pattern;
  final String? nationalPrefixFormattingRule;
  final List<String> leadingDigits;
  final String format;
  final String? intlFormat;

  const PhoneMetadataFormat({
    required this.pattern,
    required this.nationalPrefixFormattingRule,
    required this.leadingDigits,
    required this.format,
    required this.intlFormat,
  });

  Map<String, dynamic> toMap() {
    return {
      'pattern': pattern,
      'nationalPrefixFormattingRule': nationalPrefixFormattingRule,
      'leadingDigits': leadingDigits,
      'format': format,
      'intlFormat': intlFormat,
    };
  }

  factory PhoneMetadataFormat.fromMap(Map<String, dynamic> map) {
    return PhoneMetadataFormat(
      pattern: map['pattern'],
      nationalPrefixFormattingRule: map['nationalPrefixFormattingRule'],
      leadingDigits:
          (map['leadingDigits'] as List).map((el) => el as String).toList(),
      format: map['format'],
      intlFormat: map['intlFormat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneMetadataFormat.fromJson(String source) =>
      PhoneMetadataFormat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PhoneMetadataFormat(pattern: $pattern, nationalPrefixFormattingRule: $nationalPrefixFormattingRule, leadingDigits: $leadingDigits, format: $format, intlFormat: $intlFormat)';
  }
}
