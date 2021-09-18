import 'package:phone_numbers_parser/phone_numbers_parser.dart';

void main() {
  // this file is just to test compilation and see that the tree shaking works
  // as expected
  // print(PhoneParser().parseWithIsoCode('BE', '477123456'));
  print(LightPhoneParser().parseWithIsoCode(
      'BE', '477123456')); // Toggle the comment to compare with and without
}
