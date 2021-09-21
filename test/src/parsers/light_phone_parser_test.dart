import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('LightPhoneParser', () {
    final parser = LightPhoneParser();
    test('should parse with iso code', () {
      final parse = parser.parseWithIsoCode;
      final nsnFR = '479995533';
      // fr no transformation required except removing prefixes
      expect(parse('FR', '+33 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', '0033 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', '0 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', nsnFR).nsn, equals(nsnFR));
    });

    test('should copy with iso code', () {
      final copy = parser.copyWithIsoCode;
      final be = parser.parseWithIsoCode('BE', '0479 99 99 99');
      final be2 = parser.parseWithIsoCode('BE', '+32 479 99 99 99');

      final copyFR = copy(be, 'FR');
      final copyFR2 = copy(be2, 'FR');

      expect(copyFR.international, equals('+33479999999'));
      expect(copyFR2.international, equals('+33479999999'));
    });

    test('should find phone in text', () {
      final find = parser.findPotentialPhoneNumbers;
      final text = 'hey my phone number is: +33 939 876 218';
      final found = find(text).first.group(0);
      expect(found, '+33 939 876 218');
    });
  });
}
