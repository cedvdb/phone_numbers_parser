import 'package:phone_numbers_parser/src/parsers/phone_parser.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  group('PhoneParser', () {
    test('should parse with the phone number in different formats', () {
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
        parse('FR', '00 33 6 86.57.90.14').international,
        equals(international),
      );

      expect(
        parse('FR', '06 86 57 90 14').international,
        equals(international),
      );
      expect(
        parse('FR', '6 86 57 90 14').international,
        equals(international),
      );
    });

    test('should parse national', () {
      expect(
        PhoneParser.fromNational('FR', '06 86 57 90 14').international,
        equals('+33686579014'),
      );
      for (var example in examples) {
        expect(
          PhoneParser.fromNational(example['isoCode']!, example['mobile']!)
              .validate(),
          isTrue,
        );
        expect(
          PhoneParser.fromNational(
                  example['isoCode']!, example['mobile']! + '9999999')
              .validate(),
          isFalse,
        );
      }
    });

    test('should parse with iso code', () {
      for (var example in examples) {
        final parsed =
            PhoneParser.fromIsoCode(example['isoCode']!, example['mobile']!);
        expect(
          parsed.validate(),
          isTrue,
        );
        expect(
          PhoneParser.fromIsoCode(
                  example['isoCode']!, example['mobile']! + '9999999')
              .validate(),
          isFalse,
        );
      }
      // should modify national number from local to international
      // example: in argentina 0343 15 555 1212 (local) is exactly the
      // number as +54 9 343 555 1212 (international)
      expect(PhoneParser.fromIsoCode('AR', '0343155551212').international,
          equals('+5493435551212'));
      expect(PhoneParser.fromIsoCode('AR', '93435551212').international,
          equals('+5493435551212'));
    });

    test('should parse with country calling code', () {
      final parse = (c, n) => PhoneParser.fromCountryCode(c, n);
      // basic
      expect(parse('32', '479 995 533').international, equals('+32479995533'));
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
      expect(parse('+32 479 995 533').international, equals('+32479995533'));
      // same country calling code
      expect(parse('+16135550165').isoCode, equals('CA'));
      expect(parse('+12025550128').isoCode, equals('US'));
      // no transform
      expect(
          parse('+54 9 343 555 1212').international, equals('+5493435551212'));
    });

    test(
        'should output a national number in its international version only when valid',
        () {
      expect(PhoneParser.fromNational('BE', '0499 99 99 9').nsn,
          equals('049999999'));
      expect(PhoneParser.fromNational('BE', '0499 99 99 99').nsn,
          equals('499999999'));
      // expect()
    });
  });
}
