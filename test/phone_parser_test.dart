import 'package:phone_numbers_parser/src/parsers/phone_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneParser', () {
    test('should parse with iso code', () {
      final parse = PhoneParser.parseWithIsoCode;
      final international = '+33479995533';
      // fr no transformation required except removing prefixes
      expect(
        parse('FR', '+33 479 995 533').international,
        equals(international),
      );
      expect(
        parse('FR', '+33 479-995-533').international,
        equals(international),
      );
      expect(
        parse('FR', '+33 479.995.533').international,
        equals(international),
      );

      expect(
        parse('FR', '+33 479995533').international,
        equals(international),
      );
      expect(
        parse('FR', '0033 479995533').international,
        equals(international),
      );
      expect(parse('FR', '0479 995533').international, equals(international));
      expect(parse('FR', '479995533').international, equals(international));
      // should modify national number from local to international
      // example: in argentina 0343 15 555 1212 (local) is exactly the
      // number as +54 9 343 555 1212 (international)
      expect(
          parse('AR', '0343155551212').international, equals('+5493435551212'));
      expect(
          parse('AR', '93435551212').international, equals('+5493435551212'));
    });

    test('should parse with dial code', () {
      final parse = PhoneParser.parseWithDialCode;
      // basic
      expect(parse('33', '479 995 533').international, equals('+33479995533'));
      expect(parse('33', '479-995-533').international, equals('+33479995533'));
      expect(parse('33', '479.995.533').international, equals('+33479995533'));
      expect(
          parse('33', '+33 479.995.533').international, equals('+33479995533'));

      // same dial code
      expect(parse('1', '6135550165').isoCode, equals('CA'));
      expect(parse('1', '2025550128').isoCode, equals('US'));
      // transform
      expect(
          parse('54', '0343155551212').international, equals('+5493435551212'));
      expect(
          parse('54', '93435551212').international, equals('+5493435551212'));
    });

    test('should parse with raw phone number', () {
      final parse = PhoneParser.parseRaw;
      // basic
      expect(parse('+33 479 995 533').international, equals('+33479995533'));
      // expect(parse('+33 479-995-533').international, equals('+33479995533'));
      // expect(parse('00 33 479-995-533').international, equals('+33479995533'));
      // expect(parse('33 479-995-533').international, equals('+33479995533'));

      // // same dial code
      // expect(parse('+16135550165').isoCode, equals('CA'));
      // expect(parse('+12025550128').isoCode, equals('US'));
      // // no transform
      // expect(parse('+54 9 343 555 1212'), equals('+5493435551212'));
    });
  });
}
