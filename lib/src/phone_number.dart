class PhoneNumber {
  final String nationalNumber;
  final String dialCode;
  final String isoCode;
  final String value;

  PhoneNumber({
    required this.nationalNumber,
    required this.dialCode,
    required this.isoCode,
  });

  PhoneNumber.fromRaw(String raw);
  PhoneNumber.fromDialCode(String phoneNumber, String dialCode);
  PhoneNumber.fromCountryCode(String phoneNumber, String countryCode);

  String format() {}

  bool isValid() {}
}
