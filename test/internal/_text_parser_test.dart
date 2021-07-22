import 'package:phone_number_parser/src/parsers/_text_parser.dart';
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
      expect(
          TextParser.normalize('(+49 02.44/433-43)'), equals('+49024443343'));
      expect(TextParser.normalize('＋۹۹۹۹'), equals('+9999'));
    });
  });
}
