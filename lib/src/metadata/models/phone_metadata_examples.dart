class PhoneMetadataExamples {
  final String mobile;
  final String fixedLine;

  const PhoneMetadataExamples({required this.mobile, required this.fixedLine});

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'fixedLine': fixedLine,
    };
  }

  factory PhoneMetadataExamples.fromMap(Map<String, dynamic> map) {
    return PhoneMetadataExamples(
      mobile: map['mobile'] ?? '',
      fixedLine: map['fixedLine'] ?? '',
    );
  }
}
