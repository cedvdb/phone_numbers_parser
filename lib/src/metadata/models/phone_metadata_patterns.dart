import 'dart:convert';

/// Extra metadata patterns for phone numbers
class PhoneMetadataPatterns {
  final String? nationalPrefixForParsing;
  final String? nationalPrefixTransformRule;
  final String general;
  final String mobile;
  final String fixedLine;
  final String voip;
  final String tollFree;
  final String premiumRate;
  final String sharedCost;
  final String personalNumber;
  final String uan;
  final String pager;
  final String voiceMail;

  const PhoneMetadataPatterns({
    this.nationalPrefixForParsing,
    this.nationalPrefixTransformRule,
    required this.general,
    required this.mobile,
    required this.fixedLine,
    required this.voip,
    required this.tollFree,
    required this.premiumRate,
    required this.sharedCost,
    required this.personalNumber,
    required this.uan,
    required this.pager,
    required this.voiceMail,
  });

  Map<String, dynamic> toMap() {
    return {
      'nationalPrefixForParsing': nationalPrefixForParsing,
      'nationalPrefixTransformRule': nationalPrefixTransformRule,
      'general': general,
      'mobile': mobile,
      'fixedLine': fixedLine,
      'voip': voip,
      'tollFree': tollFree,
      'premiumRate': premiumRate,
      'sharedCost': sharedCost,
      'personalNumber': personalNumber,
      'uan': uan,
      'pager': pager,
      'voiceMail': voiceMail,
    };
  }

  factory PhoneMetadataPatterns.fromMap(Map<String, dynamic> map) {
    return PhoneMetadataPatterns(
      nationalPrefixForParsing: map['nationalPrefixForParsing'],
      nationalPrefixTransformRule: map['nationalPrefixTransformRule'],
      general: map['general'],
      mobile: map['mobile'],
      fixedLine: map['fixedLine'],
      voip: map['voip'] ?? '',
      tollFree: map['tollFree'] ?? '',
      premiumRate: map['premiumRate'] ?? '',
      sharedCost: map['sharedCost'] ?? '',
      personalNumber: map['personalNumber'] ?? '',
      uan: map['uan'] ?? '',
      pager: map['pager'] ?? '',
      voiceMail: map['voiceMail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneMetadataPatterns.fromJson(String source) =>
      PhoneMetadataPatterns.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PhoneMetadataPatterns(nationalPrefixForParsing: $nationalPrefixForParsing, nationalPrefixTransformRule: $nationalPrefixTransformRule, general: $general, mobile: $mobile, fixedLine: $fixedLine, voip: $voip, tollFree: $tollFree, premiumRate: $premiumRate, sharedCost: $sharedCost, personalNumber: $personalNumber, uan: $uan, pager: $pager, voiceMail: $voiceMail)';
  }
}
