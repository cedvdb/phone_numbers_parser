import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_numbers_parser/src/parsers/_country_calling_code_parser.dart';
import 'package:test/test.dart';

void main() {
  group('_CountryCodeParser', () {
    test('should normalize country calling code', () {
      expect(CountryCodeParser.normalizeCountryCode('33'), equals('33'));
      expect(CountryCodeParser.normalizeCountryCode('+33'), equals('33'));
      expect(CountryCodeParser.normalizeCountryCode(' + 33 '), equals('33'));
      expect(CountryCodeParser.normalizeCountryCode(' ＋ 33 '), equals('33'));
      expect(() => CountryCodeParser.normalizeCountryCode('not'),
          throwsA(isA<PhoneNumberException>()));
    });

    test('should remove country calling code', () {
      expect(CountryCodeParser.removeCountryCode('339', '33'), equals('9'));
    });

    test('should extract country calling code', () {
      expect(CountryCodeParser.extractCountryCode('33'), equals('33'));
      expect(CountryCodeParser.extractCountryCode('33479887766'), equals('33'));
      expect(CountryCodeParser.extractCountryCode('18889997772'), equals('1'));
    });
  });
}
