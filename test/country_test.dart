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

    test('dial code for display', () {
      expect(Country.fromIsoCode('AS').getDialCodeForDisplay(), equals('+ 1'));
      expect(
          Country.fromIsoCode('AS')
              .getDialCodeForDisplay(withLeadingDigits: true),
          equals('+ 1 684'));
    });
  });
}
