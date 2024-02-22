class PhoneMetadataExamples {
  final String mobile;
  final String fixedLine;
  final String voip;

  const PhoneMetadataExamples({
    required this.mobile,
    required this.fixedLine,
    required this.voip,
  });

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'fixedLine': fixedLine,
      'voip': voip,
    };
  }

  factory PhoneMetadataExamples.fromMap(Map<String, dynamic> map) {
    return PhoneMetadataExamples(
      mobile: map['mobile'] ?? '',
      fixedLine: map['fixedLine'] ?? '',
      voip: map['voip'] ?? '',
    );
  }
}
