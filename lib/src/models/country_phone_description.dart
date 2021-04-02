class CountryPhoneDescription {
  final String dialCode;
  final String internationalPrefix;
  final String? nationalPrefix;
  final String? nationalPrefixTransformRule;

  /// there can be more than 1 country for the same isocode
  final bool? isMainCountryForDialCode;
  final PhoneValidation validation;

  const CountryPhoneDescription({
    required this.dialCode,
    required this.internationalPrefix,
    required this.nationalPrefix,
    required this.nationalPrefixTransformRule,
    required this.isMainCountryForDialCode,
    required this.validation,
  });

  @override
  String toString() {
    return 'CountryPhoneDescription(dialCode: $dialCode, internationalPrefix: $internationalPrefix, nationalPrefix: $nationalPrefix, nationalPrefixTransformRule: $nationalPrefixTransformRule, isMainCountryForDialCode: $isMainCountryForDialCode, validation: $validation)';
  }
}

class PhoneValidation {
  final PhoneValidationRules general;
  final PhoneValidationRules mobile;
  final PhoneValidationRules fixedLine;

  const PhoneValidation({
    required this.general,
    required this.mobile,
    required this.fixedLine,
  });

  @override
  String toString() =>
      'PhoneValidation(general: $general, mobile: $mobile, fixedLine: $fixedLine)';
}

class PhoneValidationRules {
  final List<int>? lengths;
  final String pattern;

  const PhoneValidationRules({
    this.lengths,
    required this.pattern,
  });

  @override
  String toString() =>
      'PhoneValidationRules(lengths: $lengths, pattern: $pattern)';
}
