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
  });
}
