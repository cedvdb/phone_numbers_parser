import 'package:phone_number_parser/src/parsers/_iso_code_parser.dart';
import 'package:test/test.dart';

void main() {
  group('IsoCodeParser', () {
    test('should normalize iso code', () {
      expect(IsoCodeParser.normalizeIsoCode('FR'), equals('FR'));
      expect(IsoCodeParser.normalizeIsoCode(' fr '), equals('FR'));
    });
  });
}
