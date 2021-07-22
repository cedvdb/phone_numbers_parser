import 'package:phone_number_parser/phone_number_parser.dart';
import 'package:phone_number_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_number_parser/src/parsers/_dial_code_parser.dart';
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
      final metadataFR = MetadataFinder.getLightMetadataForIsoCode('FR');
      expect(DialCodeParser.removeDialCode('339', metadataFR), equals('9'));
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
