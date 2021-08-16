import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/light_phone_parser.dart';
import 'package:phone_numbers_parser/src/parsers/phone_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumber', () {
    test('should validate with pattern when created with PhoneParser', () {
      final parser = PhoneParser();
      final validMobile = parser.parseWithIsoCode('BE', '479 99 99 99');
      final validCA = parser.parseWithIsoCode('CA', '+16135550165');
      final validUS = parser.parseWithIsoCode('US', '+12025550128');
      final invalidCA = parser.parseWithIsoCode('US', '+16135550165');
      final invalidUS = parser.parseWithIsoCode('CA', '+12025550128');

      // belgian phone numbers dont have the same length for fixedLine vs mobile
      expect(validMobile.validate(), equals(true));
      expect(validMobile.validate(PhoneNumberType.mobile), equals(true));
      expect(validMobile.validate(PhoneNumberType.fixedLine), equals(false));
      // canadian and us can have same length numbers but the patterns differ
      expect(validUS.validate(), equals(true));
      expect(validCA.validate(), equals(true));
      expect(invalidUS.validate(), equals(false));
      expect(invalidCA.validate(), equals(false));
    });

    test('should validate with length when created with light phone parser',
        () {
      final parser = LightPhoneParser();
      final validMobile = parser.parseWithIsoCode('BE', '479 99 99 99');
      // belgian phone numbers dont have the same length for fixedLine vs mobile
      expect(validMobile.validate(), equals(true));
      expect(validMobile.validate(PhoneNumberType.mobile), equals(true));
      expect(validMobile.validate(PhoneNumberType.fixedLine), equals(false));
    });
  });
}
