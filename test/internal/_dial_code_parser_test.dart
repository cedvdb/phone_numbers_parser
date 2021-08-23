import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_numbers_parser/src/parsers/_dial_code_parser.dart';
import 'package:test/test.dart';

void main() {
  group('_DialCodeParser', () {
    test('should normalize dial code', () {
      expect(DialCodeParser.normalizeDialCode('33'), equals('33'));
      expect(DialCodeParser.normalizeDialCode('+33'), equals('33'));
      expect(DialCodeParser.normalizeDialCode(' + 33 '), equals('33'));
      expect(DialCodeParser.normalizeDialCode(' ＋ 33 '), equals('33'));
      expect(() => DialCodeParser.normalizeDialCode('not'),
          throwsA(isA<PhoneNumberException>()));
    });

    test('should remove dial code', () {
      expect(DialCodeParser.removeDialCode('339', '33'), equals('9'));
    });

    test('should extract dial code', () {
      expect(DialCodeParser.extractDialCode('33'), equals('33'));
      expect(DialCodeParser.extractDialCode('33479887766'), equals('33'));
      expect(DialCodeParser.extractDialCode('18889997772'), equals('1'));
    });
  });
}
