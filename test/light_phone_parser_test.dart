import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/light_phone_parser.dart';
import 'package:test/test.dart';

void main() {
  group('LightPhoneParser', () {
    test('should parse with iso code', () {
      final parse = LightPhoneParser.parseWithIsoCode;
      final nsnFR = '479995533';
      // fr no transformation required except removing prefixes
      expect(parse('FR', '+33 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', '0033 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', '0 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', nsnFR).nsn, equals(nsnFR));
    });

    test('should validate with length', () {
      final validate = LightPhoneParser.validate;
      final validMobile =
          LightPhoneParser.parseWithIsoCode('BE', '479 99 99 99');
      // belgian phone numbers dont have the same length for fixedLine vs mobile
      expect(validate(validMobile), equals(true));
      expect(validate(validMobile, PhoneNumberType.mobile), equals(true));
      expect(validate(validMobile, PhoneNumberType.fixedLine), equals(false));
    });
  });
}
