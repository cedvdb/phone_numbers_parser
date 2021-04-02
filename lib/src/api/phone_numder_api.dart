abstract class PhoneNumberAPI {
  final String nationalNumber;
  final Country country;

  String get dialCode => country.dialCode;

  // needs to parse and check validity
  PhoneNumberAPI.fromRaw(String rawPhoneNumber);
  // 
  PhoneNumberAPI.fromCountry(Country country, String nationalNumber);
  // needs to get the country and call from country
  PhoneNumber.fromIsoCode(String isoCode, String nationalNumber);
  // needs to get the country and call from country
  PhoneNumber.fromDialCode(String dialCode, String nationalNumber);
}

// set
abstract class CountryParserAPI {
  Country fromIsoCode();
  Country fromDialCode();
}

Country { 
  // bridges
}

abstract class PhoneNumberParserAPI {
  PhoneNumberAPI parse();
  PhoneNumberAPI parseWithDefaultCountry();
  String normalizeNationalNumber();
  Iterable<Match> extractPhoneNumbers();
  String normalize();
}

// Q should we accept whole phone numbers from the fromIsoCode and fromDialCode
// constructors

