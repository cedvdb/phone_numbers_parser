import 'package:phone_numbers_parser/phone_numbers_parser.dart';

void main(List<String> arguments) {
  // creation
  final frPhone = PhoneParser.parseRaw('+33 655 5705 76');
  final frPhone1 = PhoneParser.parseWithIsoCode('fr', '655 5705 76');
  final frPhone2 = PhoneParser.parseWithDialCode('33', '655 5705 76');
  final frPhone3 = PhoneParser.parseWithIsoCode('fr', '0655 5705 76');
  final allSame =
      frPhone == frPhone1 && frPhone == frPhone2 && frPhone == frPhone3;
  print(allSame); // true

  // validation
  print(PhoneParser.validate(frPhone1)); // true
  print(PhoneParser.validate(frPhone1, PhoneNumberType.mobile)); // true
  print(PhoneParser.validate(frPhone1, PhoneNumberType.fixedLine)); // false

  // changing the country
  final esPhone = frPhone.copyWithIsoCode('ES');
  print(esPhone.dialCode); // 34
  print(esPhone.isoCode); // ES
  print(esPhone.international); // '+34655570576'

  // utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = PhoneNumberUtil.findPotentialPhoneNumbers(text);
  print(text.substring(found.first.start, found.first.end));
}
