class Country {
  // English name of the country
  final String name;

  /// emoji flag
  final String flag;
  // short country code
  final String isoCode;
  // description of what the phone number should look like
  final PhoneDescription phone;

  String get dialCode => phone.dialCode;

  const Country({
    required this.name,
    required this.flag,
    required this.isoCode,
    required this.phone,
  });
}

class PhoneDescription {
  final String dialCode;
  final String internationalPrefix;
  final String? nationalPrefix;
  final String? nationalPrefixTransformRule;
  final bool? isMainCountryForIsoCode;
  final PhoneValidation validation;

  const PhoneDescription({
    required this.dialCode,
    required this.internationalPrefix,
    this.nationalPrefix,
    this.nationalPrefixTransformRule,
    this.isMainCountryForIsoCode,
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
  final String? lengths;
  final String pattern;

  const PhoneValidationRules({
    this.lengths,
    required this.pattern,
  });
}
