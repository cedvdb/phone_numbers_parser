import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumber', () {
    group('parsing', () {
      test('should parse with the phone number in different formats', () {
        PhoneNumber parse(iso, n) => PhoneNumber.fromIsoCode(iso, n);
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
          PhoneNumber.fromNational(IsoCode.FR, '06 86 57 90 14').international,
          equals('+33686579014'),
        );
      });

      test('should parse with iso code', () {
        for (var example in metadataExamplesByIsoCode.entries) {
          final parsed =
              PhoneNumber.fromIsoCode(example.key, example.value.mobile);
          expect(
            parsed.validate(),
            isTrue,
          );
          expect(
            PhoneNumber.fromIsoCode(
                    example.key, '${example.value.mobile}9999999')
                .validate(),
            isFalse,
          );
        }
        // should modify national number from local to international
        // example: in argentina 0343 15 555 1212 (local) is exactly the
        // number as +54 9 343 555 1212 (international)
        expect(
            PhoneNumber.fromIsoCode(IsoCode.AR, '0343155551212').international,
            equals('+5493435551212'));
        expect(PhoneNumber.fromIsoCode(IsoCode.AR, '93435551212').international,
            equals('+5493435551212'));
      });

      test('should parse with country calling code', () {
        PhoneNumber parse(c, n) => PhoneNumber.fromCountryCode(c, n);
        // basic
        expect(
            parse('32', '479 995 533').international, equals('+32479995533'));
        // same country calling code
        expect(parse('1', '6135550165').isoCode, equals(IsoCode.CA));
        expect(parse('1', '2025550128').isoCode, equals(IsoCode.US));
        // transform
        expect(parse('54', '0343155551212').international,
            equals('+5493435551212'));
        expect(
            parse('54', '93435551212').international, equals('+5493435551212'));
      });

      test('should parse with raw phone number', () {
        PhoneNumber parse(n) => PhoneNumber.fromRaw(n);
        // basic
        expect(parse('+32 479 995 533').international, equals('+32479995533'));
        expect(parse('+33655570500').international, equals('+33655570500'));

        // same country calling code
        expect(parse('+16135550165').isoCode, equals(IsoCode.CA));
        expect(parse('+12025550128').isoCode, equals(IsoCode.US));
        // no transform
        expect(parse('+54 9 343 555 1212').international,
            equals('+5493435551212'));
      });

      test(
          'should output a national number in its international version only when valid',
          () {
        expect(PhoneNumber.fromNational(IsoCode.BE, '0499 99 99 9').nsn,
            equals('049999999'));
        expect(PhoneNumber.fromNational(IsoCode.BE, '0499 99 99 99').nsn,
            equals('499999999'));
        // expect()
      });

      test('should parse incomplete raw phone numbers', () {
        expect(PhoneParser.fromRaw('33').isoCode, equals(IsoCode.FR));
        expect(PhoneParser.fromRaw('33').nsn, equals(''));
      });

      test('should parse international numbers in a national format',(){
        expect(PhoneNumber.fromLocale(IsoCode.US, '011 33 655 5705 76').international,
            equals('+33655570576'));
        expect(PhoneNumber.fromLocale(IsoCode.DE, '+33 655 5705 76').international,
            equals('+33655570576'));
        expect(PhoneNumber.fromLocale(IsoCode.FR, '00 33 655 5705 76').international,
            equals('+33655570576'));
        expect(PhoneNumber.fromLocale(IsoCode.BY, '810 33 655 5705 76').international,
            equals('+33655570576'));
        expect(PhoneNumber.fromLocale(IsoCode.FR, '655 5705 76').international,
            equals('+33655570576'));

      });
    });

    group('Validity', () {
      test('Should give validity for version', () {
        for (var example in metadataExamplesByIsoCode.entries) {
          expect(
            PhoneNumber.fromNational(example.key, example.value.mobile)
                .validate(),
            isTrue,
          );
          expect(
            PhoneNumber.fromNational(
                    example.key, '${example.value.mobile}9999999')
                .validate(),
            isFalse,
          );
        }
      });
    });

    group('equality', () {
      test('two phones numbers with the same values should be equal', () {
        expect(PhoneNumber(isoCode: IsoCode.FR, nsn: '479999999'),
            equals(PhoneNumber(isoCode: IsoCode.FR, nsn: '479999999')));
      });
      test('should be equa when created with different constructors', () {
        final phone1 = PhoneNumber.fromIsoCode(IsoCode.GB, '7000000000');
        final phone2 = PhoneNumber.fromCountryCode('44', '7000000000');
        final phone3 = PhoneNumber.fromRaw('+447000000000');
        expect((phone1 == phone2 && phone1 == phone3), isTrue);
      });
    });

    test('validity', () {
      final gbValidLength = PhoneNumber.fromIsoCode(IsoCode.GB, '0000000000');
      expect(gbValidLength.validateLength(), isTrue);
      expect(gbValidLength.validate(type: PhoneNumberType.mobile), isFalse);
      expect(gbValidLength.validate(type: PhoneNumberType.fixedLine), isFalse);
      expect(gbValidLength.validate(), isFalse);
      final gbValidPattern = PhoneNumber.fromIsoCode(IsoCode.GB, '7111111111');
      expect(gbValidPattern.validateLength(), isTrue);
      expect(gbValidPattern.validate(), isTrue);
    });
  });

  group('format', () {
    test('should format nsn US', () {
      String format(String phoneNumber) =>
          PhoneNumber.fromIsoCode(IsoCode.US, phoneNumber).getFormattedNsn();

      var testNumber = '';
      expect(format(testNumber), equals(''));
      testNumber = '2';
      expect(format(testNumber), equals('2'));
      testNumber = '20';
      expect(format(testNumber), equals('20'));
      testNumber = '202';
      expect(format(testNumber), equals('202'));
      testNumber = '2025';
      expect(format(testNumber), equals('202-5'));
      testNumber = '20255';
      expect(format(testNumber), equals('202-55'));
      testNumber = '202555';
      expect(format(testNumber), equals('202-555'));
      testNumber = '2025550';
      expect(format(testNumber), equals('202-555-0'));
      testNumber = '20255501';
      expect(format(testNumber), equals('202-555-01'));
      testNumber = '202555011';
      expect(format(testNumber), equals('202-555-011'));
      testNumber = '2025550119';
      expect(format(testNumber), equals('202-555-0119'));
    });

    test('should format nsn FR', () {
      String format(String phoneNumber) => PhoneNumberFormatter.formatNsn(
            PhoneNumber.fromIsoCode(IsoCode.FR, phoneNumber),
          );

      var testNumber = '6';
      expect(format(testNumber), equals('6'));
      testNumber = '68';
      expect(format(testNumber), equals('6 8'));
      testNumber = '689';
      expect(format(testNumber), equals('6 89'));
      testNumber = '6895';
      expect(format(testNumber), equals('6 89 5'));
      testNumber = '68955';
      expect(format(testNumber), equals('6 89 55'));
      testNumber = '689555';
      expect(format(testNumber), equals('6 89 55 5'));
      testNumber = '6895555';
      expect(format(testNumber), equals('6 89 55 55'));
      testNumber = '68955555';
      expect(format(testNumber), equals('6 89 55 55 5'));
      testNumber = '689555555';
      expect(PhoneNumber.fromRaw('+33689555555').getFormattedNsn(),
          equals('6 89 55 55 55'));
    });
  });

  group('range', () {
    test('count', () async {
      var zero = PhoneNumber.fromRaw('61383208100');
      var one = PhoneNumber.fromRaw('61383208101');
      var two = PhoneNumber.fromRaw('61383208102');
      var ninenine = PhoneNumber.fromRaw('61383208199');

      expect(PhoneNumberRange(zero, one).count, equals(2));
      expect(PhoneNumberRange(zero, two).count, equals(3));
      expect(PhoneNumberRange(two, zero).count, equals(3));

      expect(PhoneNumberRange(zero, ninenine).count, equals(100));
    });

    test('range', () async {
      var zero = PhoneNumber.fromRaw('61383208100');
      var one = PhoneNumber.fromRaw('61383208101');
      var two = PhoneNumber.fromRaw('61383208102');
      var ninenine = PhoneNumber.fromRaw('61383208199');

      expect(PhoneNumberRange(zero, one).expandRange().length, equals(2));
      expect(PhoneNumberRange(zero, two).expandRange().length, equals(3));
      expect(
          PhoneNumberRange(zero, ninenine).expandRange().length, equals(100));

      expect(PhoneNumberRange(zero, one).expandRange(),
          containsAllInOrder([zero, one]));

      expect(PhoneNumberRange(zero, ninenine).expandRange(),
          containsAllInOrder([zero, one, two, ninenine]));
    });

    test('add/subtract', () async {
      var start = PhoneNumber.fromRaw('61383208100');

      start = start + 1;
      expect(start, equals(PhoneNumber.fromRaw('61383208101')));

      start = start - 1;
      expect(start, equals(PhoneNumber.fromRaw('61383208100')));
    });

    test('comparision', () async {
      var zero = PhoneNumber.fromRaw('61383208100');
      var one = PhoneNumber.fromRaw('61383208101');

      expect(zero == zero, isTrue);
      expect(zero < one, isTrue);
      expect(zero <= one, isTrue);
      expect(zero > one, isFalse);
      expect(zero >= one, isFalse);
    });

    test('sequence', () async {
      var zero = PhoneNumber.fromRaw('61383208100');
      var one = PhoneNumber.fromRaw('61383208101');
      var two = PhoneNumber.fromRaw('61383208102');

      expect(zero.isAdjacentTo(one), isTrue);
      expect(zero.isSequentialTo(one), isTrue);

      expect(zero.isAdjacentTo(two), isFalse);
      expect(zero.isSequentialTo(two), isFalse);

      expect(one.isAdjacentTo(zero), isTrue);
      expect(one.isSequentialTo(zero), isFalse);

      expect(zero.isAdjacentTo(two), isFalse);
      expect(zero.isSequentialTo(two), isFalse);
    });
  });
}
