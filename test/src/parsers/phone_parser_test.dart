import 'package:phone_numbers_parser/src/parsers/_phone_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneParser', () {
    test('should parse national', () {
      expect(
        PhoneParser.fromNational('FR', '6 86 57 90 14').international,
        equals('+33686579014'),
      );
    });

    test('should parse with iso code', () {
      final parse = (iso, n) => PhoneParser.fromIsoCode(iso, n);
      final international = '+33686579014';
      // fr no transformation required except removing prefixes
      expect(
        parse('FR', '+33 6 86 57 90 14').international,
        equals(international),
      );
      expect(
        parse('FR', '+33 6 865-79-014').international,
        equals(international),
      );
      expect(
        parse('FR', '+33 6 86.57.90.14').international,
        equals(international),
      );

      expect(
        parse('FR', '+33 6 86 57 90 14').international,
        equals(international),
      );
      expect(
        parse('FR', '00 33 6 86 57 90 14').international,
        equals(international),
      );
      expect(
          parse('FR', '06 86 57 90 14').international, equals(international));
      expect(parse('FR', '6 86 57 90 14').international, equals(international));
      // should modify national number from local to international
      // example: in argentina 0343 15 555 1212 (local) is exactly the
      // number as +54 9 343 555 1212 (international)
      expect(
          parse('AR', '0343155551212').international, equals('+5493435551212'));
      expect(
          parse('AR', '93435551212').international, equals('+5493435551212'));
    });

    test('should parse with country calling code', () {
      final parse = (c, n) => PhoneParser.fromCountryCode(c, n);
      // basic
      expect(parse('33', '479 995 533').international, equals('+33479995533'));
      expect(parse('33', '479-995-533').international, equals('+33479995533'));
      expect(parse('33', '479.995.533').international, equals('+33479995533'));
      expect(
          parse('33', '+33 479.995.533').international, equals('+33479995533'));

      // same country calling code
      expect(parse('1', '6135550165').isoCode, equals('CA'));
      expect(parse('1', '2025550128').isoCode, equals('US'));
      // transform
      expect(
          parse('54', '0343155551212').international, equals('+5493435551212'));
      expect(
          parse('54', '93435551212').international, equals('+5493435551212'));
    });

    test('should parse with raw phone number', () {
      final parse = (n) => PhoneParser.fromRaw(n);
      // basic
      expect(parse('+33 479 995 533').international, equals('+33479995533'));
      expect(parse('+33 479-995-533').international, equals('+33479995533'));
      expect(parse('00 33 479-995-533').international, equals('+33479995533'));
      expect(parse('33 479-995-533').international, equals('+33479995533'));

      // same country calling code
      expect(parse('+16135550165').isoCode, equals('CA'));
      expect(parse('+12025550128').isoCode, equals('US'));
      // no transform
      expect(
          parse('+54 9 343 555 1212').international, equals('+5493435551212'));
    });
  });
}
