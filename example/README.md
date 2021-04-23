```dart
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

void main(List<String> arguments) {
// creation
  final frPhone = PhoneNumber.fromRaw('+33 655 5705 76');
  final frPhone1 = PhoneNumber.fromIsoCode('fr', '655 5705 76');
  final frPhone2 = PhoneNumber.fromDialCode('33', '655 5705 76');
  final frPhone3 = PhoneNumber.fromIsoCode('fr', '0655 5705 76');
  final international = '+33655570576';
  final allInternationalEqual = international == frPhone.international &&
      international == frPhone1.international &&
      international == frPhone2.international &&
      international == frPhone3.international;
  print(allInternationalEqual); // true

// extracting info
  print(frPhone.valid); // true
  print(frPhone.dialCode); // 33
  print(frPhone.isoCode); // fr
  print(frPhone.validate(PhoneNumberType.fixedLine)); // false
  print(frPhone.validate(PhoneNumberType.mobile)); // true

// changing the country
  final esPhone = frPhone.copyWithIsoCode('ES');
  print(esPhone.dialCode); // 34
  print(esPhone.isoCode); // ES
  print(esPhone.international); // '+34655570576'

// utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = PhoneNumberUtil.findPotentialPhoneNumbers(text);
  print(text.substring(found.first.start, found.first.end));
// country list for display
  final allCountries =
      countries; // contains name, isoCode, dialCode, leading digits, etc
  print(allCountries.length);
}


```