import 'package:phone_numbers_parser/src/models/phone_description.dart';

/// Country regroup informations for displaying a list of countries
class Country {
  /// English name of the country
  final String name;

  /// emoji flag
  final String flag;

  /// short country code
  final String isoCode;

  /// description of what the phone number should look like
  final CountryPhoneDescription phone;

  /// country dialing code to call them internationally
  String get dialCode => phone.dialCode;

  const Country({
    required this.name,
    required this.flag,
    required this.isoCode,
    required this.phone,
  });
}
