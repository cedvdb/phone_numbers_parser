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
  NOT_FOUND,

  /// Invalid phone number
  INVALID,

  /// invalid country code
  ///
  /// Valid example: 33 for france
  INVALID_COUNTRY_CALLING_CODE,

  /// invalid alpha-2 code (example valid)
  ///
  /// Valid example: FR for france
  INVALID_ISO_CODE,

  /// Input has reached the maximum limit
  INPUT_IS_TOO_LONG
}
