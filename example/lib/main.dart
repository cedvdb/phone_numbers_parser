import 'package:phone_numbers_parser/phone_numbers_parser.dart';

void main(List<String> arguments) {
  final parser = PhoneParser();
  // creation
  final frPhone = parser.parseRaw('+33 655 5705 76');
  final frPhone1 = parser.parseWithIsoCode('fr', '655 5705 76');
  final frPhone2 = parser.parseWithDialCode('33', '655 5705 76');
  final frPhone3 = parser.parseWithIsoCode('fr', '0655 5705 76');
  final allSame =
      frPhone == frPhone1 && frPhone == frPhone2 && frPhone == frPhone3;
  print(allSame); // true

  // validation
  print(parser.validate(frPhone)); // true
  print(parser.validate(frPhone, PhoneNumberType.mobile)); // true
  print(parser.validate(frPhone, PhoneNumberType.fixedLine)); // false

  // changing the country
  final esPhone = parser.copyWithIsoCode(frPhone, 'ES');
  print(esPhone.dialCode); // 34
  print(esPhone.isoCode); // ES
  print(esPhone.international); // '+34655570576'

  // utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = parser.findPotentialPhoneNumbers(text);
  print(text.substring(found.first.start, found.first.end));
}
