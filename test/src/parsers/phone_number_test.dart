import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumber', () {
    test('two phones numbers with the same values should be equal', () {
      expect(PhoneNumber(isoCode: IsoCode.FR, nsn: '479999999'),
          equals(PhoneNumber(isoCode: IsoCode.FR, nsn: '479999999')));
    });
    test('creation', () {
      final phone1 = PhoneNumber.fromIsoCode(IsoCode.GB, '7000000000');
      final phone2 = PhoneNumber.fromCountryCode('44', '7000000000');
      final phone3 = PhoneNumber.fromRaw('+447000000000');
      expect((phone1 == phone2 && phone1 == phone3), isTrue);
    });

    test('validity', () {
      final gbValidLength = PhoneNumber.fromIsoCode(IsoCode.GB, '0000000000');
      expect(gbValidLength.validateLength(), isTrue);
      expect(gbValidLength.validate(type: PhoneNumberType.mobile), isFalse);
      expect(gbValidLength.validate(type: PhoneNumberType.fixedLine), isFalse);
      expect(gbValidLength.validate(), isFalse);
      final gbValidPattern = PhoneNumber.fromIsoCode(IsoCode.GB, '7111111111');
      expect(gbValidPattern.validateLength(), isTrue);
      expect(gbValidPattern.validate(), isTrue);
    });
  });

  group('zeroes', () {});
}
