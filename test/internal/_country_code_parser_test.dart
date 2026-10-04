import 'package:phone_numbers_parser/src/parsers/_country_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/phone_number_exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('_CountryCodeParser', () {
    test('should extract country calling code', () {
      expect(CountryCodeParser.extractCountryCode('33'), equals(('33', '')));
      expect(CountryCodeParser.extractCountryCode('33479887766'),
          equals(('33', '479887766')));
      expect(CountryCodeParser.extractCountryCode('18889997772'),
          equals(('1', '8889997772')));
    });

    test('should throw an invalid exception when there are no digits', () {
      expect(
        () => CountryCodeParser.extractCountryCode(''),
        throwsA(
          isA<PhoneNumberException>()
              .having((e) => e.code, 'code', Code.invalid),
        ),
      );
    });

    test('should throw a notFound exception when no country code matches', () {
      expect(
        () => CountryCodeParser.extractCountryCode('9999999'),
        throwsA(
          isA<PhoneNumberException>()
              .having((e) => e.code, 'code', Code.notFound),
        ),
      );
    });
  });
}
