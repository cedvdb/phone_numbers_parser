import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('Country', () {
    test('should create with isoCode ', () {
      expect(Country.fromIsoCode('fr').name, equals('France'));
      expect(Country.fromIsoCode('FR').name, equals('France'));
      expect(() => Country.fromIsoCode('WRONG'),
          throwsA(TypeMatcher<PhoneNumberException>()));
    });
    test('should create with dialCode ', () {
      expect(Country.fromDialCode('33').name, equals('France'));
      expect(Country.fromDialCode('+33').name, equals('France'));
      expect(() => Country.fromDialCode('0'),
          throwsA(TypeMatcher<PhoneNumberException>()));
    });
  });
}
