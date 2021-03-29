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
}

class PhoneValidationRules {
  final List<int>? lengths;
  final String pattern;

  const PhoneValidationRules({
    this.lengths,
    required this.pattern,
  });
}
