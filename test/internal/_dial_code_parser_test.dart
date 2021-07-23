import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_numbers_parser/src/parsers/_dial_code_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
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

    test('should find matching metadata', () {
      expect(
        DialCodeParser.selectMetadataMatchForDialCode(
          '33',
          '0478999999',
          MetadataFinder.getExtendedMetadatasForDialCode('33'),
        ).isoCode,
        equals('FR'),
      );
      expect(
        DialCodeParser.selectMetadataMatchForDialCode(
          '1',
          '2025550128',
          MetadataFinder.getExtendedMetadatasForDialCode('1'),
        ).isoCode,
        equals('US'),
      );
      expect(
        DialCodeParser.selectMetadataMatchForDialCode(
          '1',
          '6135550165',
          MetadataFinder.getExtendedMetadatasForDialCode('1'),
        ).isoCode,
        equals('CA'),
      );
    });
  });
}
