import 'dart:convert';

/// Extra metadata patterns for phone numbers
class PhoneMetadataPatterns {
  final String? nationalPrefixForParsing;
  final String? nationalPrefixTransformRule;
  final String general;
  final String mobile;
  final String fixedLine;

  const PhoneMetadataPatterns({
    this.nationalPrefixForParsing,
    this.nationalPrefixTransformRule,
    required this.general,
    required this.mobile,
    required this.fixedLine,
  });

  Map<String, dynamic> toMap() {
    return {
      'nationalPrefixForParsing': nationalPrefixForParsing,
      'nationalPrefixTransformRule': nationalPrefixTransformRule,
      'general': general,
      'mobile': mobile,
      'fixedLine': fixedLine,
    };
  }

  factory PhoneMetadataPatterns.fromMap(Map<String, dynamic> map) {
    return PhoneMetadataPatterns(
      nationalPrefixForParsing: map['nationalPrefixForParsing'],
      nationalPrefixTransformRule: map['nationalPrefixTransformRule'],
      general: map['general'],
      mobile: map['mobile'],
      fixedLine: map['fixedLine'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneMetadataPatterns.fromJson(String source) =>
      PhoneMetadataPatterns.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PhoneMetadataPatterns(nationalPrefixForParsing: $nationalPrefixForParsing, nationalPrefixTransformRule: $nationalPrefixTransformRule, general: $general, mobile: $mobile, fixedLine: $fixedLine)';
  }
}
