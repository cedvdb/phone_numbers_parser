import 'package:phone_numbers_parser/phone_numbers_parser.dart';

void main(List<String> arguments) {
  final parser = PhoneParser(); // alternatively LightPhoneParser
  // creation
  final frPhone = parser.parseRaw('+33 655 5705 76');
  final frPhone1 = parser.parseWithIsoCode('fr', '655 5705 76');
  final frPhone2 = parser.parseWithCountryCode('33', '655 5705 76');
  final frPhone3 = parser.parseWithIsoCode('fr', '0655 5705 76');
  final allSame =
      frPhone == frPhone1 && frPhone == frPhone2 && frPhone == frPhone3;
  print(allSame); // true

  // validation
  print(parser.validate(frPhone1)); // true
  print(parser.validate(frPhone1, PhoneNumberType.mobile)); // true
  print(parser.validate(frPhone1, PhoneNumberType.fixedLine)); // false

  // changing the country
  final esPhone = parser.copyWithIsoCode(frPhone, 'ES');
  print(esPhone.countryCode); // 34
  print(esPhone.isoCode); // ES
  print(esPhone.international); // '+34655570576'

  // utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = parser.findPotentialPhoneNumbers(text);
  print(text.substring(found.first.start, found.first.end));

  // Ranges
  final first = parser.parseRaw('+33 655 5705 00');
  final last = parser.parseRaw('+33 655 5705 03');
  final range = PhoneNumberRange(first, last);

  print('Count: ${range.count}');
  print('Expand: ${range.expandRange().join(',')}');

  if (first > last) {
    print("this shouldn't be.");
  }

  final one = parser.parseRaw('+33 655 5705 01');
  final two = parser.parseRaw('+33 655 5705 02');

  if (one.isAdjacentTo(two)) {
    print('We are together');
  }
  if (one.isSequentialTo(two)) {
    print('$two comes after $one');
  }

  /// treat the phone no. like an int
  var three = two + 1;
  print('Its still a phone No. $three');
  two - 1 == one;
  var another = one + 2;
  print('$another == $three');
}
