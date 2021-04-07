import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  test('should find phone number in text', () {
    final find = PhoneNumberUtil.findPotentialPhoneNumbers;
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

  test('should normalize', () {
    expect(PhoneNumberUtil.normalize('(+49 02.44/433-43)'),
        equals('+49024443343'));
    expect(PhoneNumberUtil.normalize('＋۹۹۹۹'), equals('+9999'));
  });
}
