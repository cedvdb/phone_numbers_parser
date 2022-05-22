import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneParser', () {
    test('should parse with the phone number in different formats', () {
      PhoneNumber parse(iso, n) => PhoneParser.fromIsoCode(iso, n);
      final international = '+33686579014';
      // fr no transformation required except removing prefixes
      expect(
        parse(IsoCode.FR, '+33 6 86 57 90 14').international,
        equals(international),
      );
      expect(
        parse(IsoCode.FR, '+33 6 865-79-014').international,
        equals(international),
      );
      expect(
        parse(IsoCode.FR, '00 33 6 86.57.90.14').international,
        equals(international),
      );

      expect(
        parse(IsoCode.FR, '06 86 57 90 14').international,
        equals(international),
      );
      expect(
        parse(IsoCode.FR, '6 86 57 90 14').international,
        equals(international),
      );
    });

    test('should parse national', () {
      expect(
        PhoneParser.fromNational(IsoCode.FR, '06 86 57 90 14').international,
        equals('+33686579014'),
      );
      for (var example in metadataExamplesByIsoCode.entries) {
        expect(
          PhoneParser.fromNational(example.key, example.value.mobile)
              .validate(),
          isTrue,
        );
        expect(
          PhoneParser.fromNational(
                  example.key, '${example.value.mobile}9999999')
              .validate(),
          isFalse,
        );
      }
    });

    test('should parse with iso code', () {
      for (var example in metadataExamplesByIsoCode.entries) {
        final parsed =
            PhoneParser.fromIsoCode(example.key, example.value.mobile);
        expect(
          parsed.validate(),
          isTrue,
        );
        expect(
          PhoneParser.fromIsoCode(example.key, '${example.value.mobile}9999999')
              .validate(),
          isFalse,
        );
      }
      // should modify national number from local to international
      // example: in argentina 0343 15 555 1212 (local) is exactly the
      // number as +54 9 343 555 1212 (international)
      expect(PhoneParser.fromIsoCode(IsoCode.AR, '0343155551212').international,
          equals('+5493435551212'));
      expect(PhoneParser.fromIsoCode(IsoCode.AR, '93435551212').international,
          equals('+5493435551212'));
    });

    test('should parse with country calling code', () {
      PhoneNumber parse(c, n) => PhoneParser.fromCountryCode(c, n);
      // basic
      expect(parse('32', '479 995 533').international, equals('+32479995533'));
      // same country calling code
      expect(parse('1', '6135550165').isoCode, equals(IsoCode.CA));
      expect(parse('1', '2025550128').isoCode, equals(IsoCode.US));
      // transform
      expect(
          parse('54', '0343155551212').international, equals('+5493435551212'));
      expect(
          parse('54', '93435551212').international, equals('+5493435551212'));
    });

    test('should parse with raw phone number', () {
      PhoneNumber parse(n) => PhoneParser.fromRaw(n);
      // basic
      expect(parse('+32 479 995 533').international, equals('+32479995533'));
      // same country calling code
      expect(parse('+16135550165').isoCode, equals(IsoCode.CA));
      expect(parse('+12025550128').isoCode, equals(IsoCode.US));
      // no transform
      expect(
          parse('+54 9 343 555 1212').international, equals('+5493435551212'));
    });

    test(
        'should output a national number in its international version only when valid',
        () {
      expect(PhoneParser.fromNational(IsoCode.BE, '0499 99 99 9').nsn,
          equals('049999999'));
      expect(PhoneParser.fromNational(IsoCode.BE, '0499 99 99 99').nsn,
          equals('499999999'));
      // expect()
    });

    test('should parse incomplete raw phone numbers', () {
      expect(PhoneParser.fromRaw('33').isoCode, equals(IsoCode.FR));
      expect(PhoneParser.fromRaw('33').nsn, equals(''));
    });
  });
}
