import 'package:phone_numbers_parser/phone_number_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_numbers_parser/src/parsers/_dial_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/light_phone_parser.dart';
import 'package:test/test.dart';

void main() {
  group('LightPhoneParser', () {
    test('should parse with iso code', () {
      LightPhoneParser.parseWithIsoCode('FR', '+33 479 99 55 33');
    });
  });
}
