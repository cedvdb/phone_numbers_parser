enum PhoneNumberType { mobile, fixedLine }

class CountryPhoneDescription {
  final String dialCode;
  final String internationalPrefix;
  final String? leadingDigits;
  final String? nationalPrefix;
  final String? nationalPrefixForParsing;
  final String? nationalPrefixTransformRule;

  /// there can be more than 1 country for the same isocode
  final bool? isMainCountryForDialCode;
  final PhoneValidation validation;

  const CountryPhoneDescription({
    required this.dialCode,
    required this.leadingDigits,
    required this.internationalPrefix,
    required this.nationalPrefix,
    required this.nationalPrefixForParsing,
    required this.nationalPrefixTransformRule,
    required this.isMainCountryForDialCode,
    required this.validation,
  });

  @override
  String toString() {
    return 'CountryPhoneDescription(dialCode: $dialCode, internationalPrefix: $internationalPrefix, leadingDigits: $leadingDigits, nationalPrefix: $nationalPrefix, nationalPrefixForParsing: $nationalPrefixForParsing, nationalPrefixTransformRule: $nationalPrefixTransformRule, isMainCountryForDialCode: $isMainCountryForDialCode, validation: $validation)';
  }

  Map<String, dynamic> toMap() {
    return {
      'dialCode': dialCode,
      'internationalPrefix': internationalPrefix,
      'leadingDigits': leadingDigits,
      'nationalPrefix': nationalPrefix,
      'nationalPrefixForParsing': nationalPrefixForParsing,
      'nationalPrefixTransformRule': nationalPrefixTransformRule,
      'isMainCountryForDialCode': isMainCountryForDialCode,
      'validation': validation.toMap(),
    };
  }

  factory CountryPhoneDescription.fromMap(Map<String, dynamic> map) {
    return CountryPhoneDescription(
      dialCode: map['dialCode'],
      internationalPrefix: map['internationalPrefix'],
      leadingDigits: map['leadingDigits'],
      nationalPrefix: map['nationalPrefix'],
      nationalPrefixForParsing: map['nationalPrefixForParsing'],
      nationalPrefixTransformRule: map['nationalPrefixTransformRule'],
      isMainCountryForDialCode: map['isMainCountryForDialCode'],
      validation: PhoneValidation.fromMap(map['validation']),
    );
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

  Map<String, dynamic> toMap() {
    return {
      'general': general.toMap(),
      'mobile': mobile.toMap(),
      'fixedLine': fixedLine.toMap(),
    };
  }

  factory PhoneValidation.fromMap(Map<String, dynamic> map) {
    return PhoneValidation(
      general: PhoneValidationRules.fromMap(map['general']),
      mobile: PhoneValidationRules.fromMap(map['mobile']),
      fixedLine: PhoneValidationRules.fromMap(map['fixedLine']),
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'lengths': lengths,
      'pattern': pattern,
    };
  }

  factory PhoneValidationRules.fromMap(Map<String, dynamic> map) {
    return PhoneValidationRules(
      lengths: List<int>.from(map['lengths'] ?? []),
      pattern: map['pattern'],
    );
  }
}
