class PhoneNumberException {
  final Code code;
  final String? description;

  const PhoneNumberException({
    required this.code,
    this.description,
  });

  @override
  String toString() =>
      'PhoneNumberException(code: $code, description: $description)';
}

enum Code {
  /// A phone number was not found
  notFound,

  /// Invalid phone number
  invalid,

  /// invalid country code
  ///
  /// Valid example: 33 for france
  invalidCountryCallingCode,

  /// invalid alpha-2 code (example valid)
  ///
  /// Valid example: FR for france
  invalidIsoCode,

  /// Input has reached the maximum limit
  inputIsTooLong
}
