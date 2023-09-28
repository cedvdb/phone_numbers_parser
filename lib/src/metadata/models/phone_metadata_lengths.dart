import 'dart:convert';

class PhoneMetadataLengths {
  final List<int> general;
  final List<int> mobile;
  final List<int> fixedLine;

  const PhoneMetadataLengths({
    required this.general,
    required this.mobile,
    required this.fixedLine,
  });

  Map<String, dynamic> toMap() {
    return {
      'general': general,
      'mobile': mobile,
      'fixedLine': fixedLine,
    };
  }

  factory PhoneMetadataLengths.fromMap(Map<String, dynamic> map) {
    return PhoneMetadataLengths(
      general: List<int>.from(map['general']),
      mobile: List<int>.from(map['mobile']),
      fixedLine: List<int>.from(map['fixedLine']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneMetadataLengths.fromJson(String source) =>
      PhoneMetadataLengths.fromMap(json.decode(source));

  @override
  String toString() =>
      'PhoneMetadataLengths(general: $general, mobile: $mobile, fixedLine: $fixedLine)';
}
