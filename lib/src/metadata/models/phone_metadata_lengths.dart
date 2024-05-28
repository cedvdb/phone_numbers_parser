import 'dart:convert';

class PhoneMetadataLengths {
  final List<int> general;
  final List<int> mobile;
  final List<int> fixedLine;
  final List<int> voip;
  final List<int> tollFree;
  final List<int> premiumRate;
  final List<int> sharedCost;
  final List<int> personalNumber;
  final List<int> uan;
  final List<int> pager;
  final List<int> voiceMail;

  const PhoneMetadataLengths({
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

  factory PhoneMetadataLengths.fromMap(Map<String, dynamic> map) {
    return PhoneMetadataLengths(
      general: List<int>.from(map['general']),
      mobile: List<int>.from(map['mobile']),
      fixedLine: List<int>.from(map['fixedLine']),
      voip: List<int>.from(map['voip'] ?? []),
      tollFree: List<int>.from(map['tollFree'] ?? []),
      premiumRate: List<int>.from(map['premiumRate'] ?? []),
      sharedCost: List<int>.from(map['sharedCost'] ?? []),
      personalNumber: List<int>.from(map['personalNumber'] ?? []),
      uan: List<int>.from(map['uan'] ?? []),
      pager: List<int>.from(map['pager'] ?? []),
      voiceMail: List<int>.from(map['voiceMail'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneMetadataLengths.fromJson(String source) =>
      PhoneMetadataLengths.fromMap(json.decode(source));

  @override
  String toString() =>
      'PhoneMetadataLengths(general: $general, mobile: $mobile, fixedLine: $fixedLine, voip: $voip, tollFree: $tollFree, premiumRate: $premiumRate, shareCost: $sharedCost, personalNumber: $personalNumber, uan: $uan, pager: $pager, voiceMail: $voiceMail)';
}
