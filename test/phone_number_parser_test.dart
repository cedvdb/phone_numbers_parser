import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumberParser', () {
    test('should find phone number in text', () {
      final f = PhoneNumberParser.findPotentialPhoneNumbers;
      expect(f('+49024443343').isEmpty, equals(false));
      expect(f('0049024443').isEmpty, equals(false));
      expect(f('(+49 02.44/433-43)').isEmpty, equals(false));
      expect(f('＋۹۹۹۹۹9۹').isEmpty, equals(false));
      expect(f('＋9nothing here').isEmpty, equals(true));
      expect(
        f(
          'Hello, my phone number is: +49024443343.',
        ).first.group(0),
        equals('+49024443343'),
      );
      expect(
        f('Try +49024443343 or +83443829').toList().length,
        equals(2),
      );
    });

    test('should normalize', () {
      expect(PhoneNumberParser.normalize('(+49 02.44/433-43)'),
          equals('+49024443343'));
      expect(PhoneNumberParser.normalize('＋۹۹۹۹'), equals('+9999'));
    });

    test('should parse national number', () {
      final france = Country.fromIsoCode('fr');
      // with a transform rule
      final anguilla = Country.fromIsoCode('AI');
      expect(PhoneNumberParser.parseNationalNumber('0423322223', france),
          equals('423322223'));
      expect(PhoneNumberParser.parseNationalNumber('4333555)', anguilla),
          equals('2644333555'));
    });
  });
}
