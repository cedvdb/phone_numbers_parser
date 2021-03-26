class PhoneNumberException {
  final Code code;
  final String? description;

  PhoneNumberException({
    required this.code,
    this.description,
  });
}

enum Code {
  /// A phone number was not found
  NOT_FOUND,

  /// Invalid phone number
  INVALID,

  /// Input has reached the maximum limit
  INPUT_IS_TOO_LONG
}
