import 'package:phone_numbers_parser/src/parsers/_text_parser.dart';
import 'package:test/test.dart';

void main() {
  group('TextParser', () {
    test('should find phone number in text', () {
      final find = TextParser.findPotentialPhoneNumbers;
      expect(find('+33 0466 46 46 46').isEmpty, equals(false));
      expect(find('0033 0466 46 46 46').isEmpty, equals(false));
      expect(find('(+33) 0466-46-46-46').isEmpty, equals(false));
      expect(find('+33 0466/46/46/46').isEmpty, equals(false));
      expect(find('+33 0466.46.46.46').isEmpty, equals(false));
      expect(find('＋۹۹۹۹۹9۹').isEmpty, equals(false));
      expect(find('＋9nothing here').isEmpty, equals(true));
      expect(find('Tel: +49024443343.').first.group(0), equals('+49024443343'));
      expect(
        find('Try +49024443343 or +83443829').toList().length,
        equals(2),
      );
    });

    test('should normalize phone number', () {
      expect(TextParser.normalizePhoneNumber('(+49 02.44/433-43)'),
          equals('+49024443343'));
      expect(TextParser.normalizePhoneNumber('＋۹۹۹۹'), equals('+9999'));
    });

    test('should drop characters that are not part of a phone number', () {
      // letters are not normalized, they are dropped (known limitation)
      expect(TextParser.normalizePhoneNumber('1-800-FLOWERS'), equals('1800'));
      expect(TextParser.normalizePhoneNumber('not a phone'), equals(''));
      expect(TextParser.normalizePhoneNumber('   '), equals(''));
    });

    test('should only find numbers of at least 7 digits', () {
      expect(TextParser.findPotentialPhoneNumbers('12345').isEmpty, isTrue);
      expect(TextParser.findPotentialPhoneNumbers('123456').isEmpty, isTrue);
      expect(TextParser.findPotentialPhoneNumbers('1234567').isEmpty, isFalse);
    });
  });
}
