import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/phone_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneParser', () {
    final parser = PhoneParser();
    test('should parse with iso code', () {
      final parse = parser.parseWithIsoCode;
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
      final parse = parser.parseWithDialCode;
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
      final parse = parser.parseRaw;
      // basic
      expect(parse('+33 479 995 533').international, equals('+33479995533'));
      expect(parse('+33 479-995-533').international, equals('+33479995533'));
      expect(parse('00 33 479-995-533').international, equals('+33479995533'));
      expect(parse('33 479-995-533').international, equals('+33479995533'));

      // same dial code
      expect(parse('+16135550165').isoCode, equals('CA'));
      expect(parse('+12025550128').isoCode, equals('US'));
      // no transform
      expect(
          parse('+54 9 343 555 1212').international, equals('+5493435551212'));
    });

    test('should validate with pattern', () {
      final validate = parser.validate;
      final validMobile = parser.parseWithIsoCode('BE', '479 99 99 99');
      final validCA = parser.parseWithIsoCode('CA', '+16135550165');
      final validUS = parser.parseWithIsoCode('US', '+12025550128');
      final invalidCA = parser.parseWithIsoCode('US', '+16135550165');
      final invalidUS = parser.parseWithIsoCode('CA', '+12025550128');

      // belgian phone numbers dont have the same length for fixedLine vs mobile
      expect(validate(validMobile), equals(true));
      expect(validate(validMobile, PhoneNumberType.mobile), equals(true));
      expect(validate(validMobile, PhoneNumberType.fixedLine), equals(false));
      // canadian and us can have same length numbers but the patterns differ
      expect(validate(validUS), equals(true));
      expect(validate(validCA), equals(true));
      expect(validate(invalidUS), equals(false));
      expect(validate(invalidCA), equals(false));
    });
  });
}
