import 'package:phone_numbers_parser/src/parsers/phone_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneParser', () {
    test('should parse with iso code', () {
      final parse = PhoneParser.parseWithIsoCode;
      final nsnFR = '479995533';
      // fr no transformation required except removing prefixes
      expect(parse('FR', '+33 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', '0033 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', '0 $nsnFR').nsn, equals(nsnFR));
      expect(parse('FR', nsnFR).nsn, equals(nsnFR));
      // should modify national number from local to international
      // example: in argentina 0343 15 555 1212 (local) is exactly the
      // number as +54 9 343 555 1212 (international)
      expect(
          parse('AR', '0343155551212').international, equals('+5493435551212'));
      expect(
          parse('AR', '93435551212').international, equals('+5493435551212'));
    });
  });
}
