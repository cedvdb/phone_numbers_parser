import 'package:phone_numbers_parser/src/parsers/light_phone_parser.dart';
import 'package:test/test.dart';

void main() {
  group('LightPhoneParser', () {
    test('should parse with iso code', () {
      LightPhoneParser.parseWithIsoCode('FR', '+33 479 99 55 33');
    });
  });
}
