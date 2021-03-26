class Country {
  final String isoCode;
  final String dialCode;
  final Mobile mobile;
  final String internationalPrefix;
  final String? nationalPrefix;
  final bool isMainCountryForIsoCode;

  const Country({
    required this.isoCode,
    required this.dialCode,
    required this.mobile,
    required this.internationalPrefix,
    required this.nationalPrefix,
    required this.isMainCountryForIsoCode,
  });
}

class Mobile {
  final String lengths;
  final String pattern;

  Mobile({
    required this.lengths,
    required this.pattern,
  });
}
