import 'package:phone_numbers_parser/src/models/country_phone_description.dart';
import 'package:phone_numbers_parser/src/parsers/country_parser.dart';

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

  @override
  String toString() {
    return 'Country(name: $name, flag: $flag, isoCode: $isoCode, phone: $phone)';
  }

  static Country fromIsoCode(String isoCode) =>
      CountryParser.fromIsoCode(isoCode);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'flag': flag,
      'isoCode': isoCode,
      'phone': phone.toMap(),
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'],
      flag: map['flag'],
      isoCode: map['isoCode'],
      phone: CountryPhoneDescription.fromMap(map['phone']),
    );
  }
}
