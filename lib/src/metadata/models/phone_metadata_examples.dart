class PhoneMetadataExamples {
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

  const PhoneMetadataExamples({
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

  factory PhoneMetadataExamples.fromMap(Map<String, dynamic> map) {
    return PhoneMetadataExamples(
      mobile: map['mobile'] ?? '',
      fixedLine: map['fixedLine'] ?? '',
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
}
