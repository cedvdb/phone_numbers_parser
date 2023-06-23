import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/generated/metadata_examples_by_iso_code.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumber', () {
    group('parsing', () {
      test('should parse the phone number in different formats', () {
        final international = '+33686579014';
        // fr no transformation required except removing prefixes
        expect(
          PhoneNumber.parse('+33 6 86 57 90 14').international,
          equals(international),
        );
        expect(
          PhoneNumber.parse('+33 6 865-79-014').international,
          equals(international),
        );
        expect(
          PhoneNumber.parse('00 33 6 86.57.90.14').international,
          equals(international),
        );
      });

      test('should parse incomplete phone numbers', () {
        // fr no transformation required except removing prefixes
        expect(
          // this phone number nsn should start with the same digits as the country code
          PhoneNumber.parse('91', destinationCountry: IsoCode.IN).international,
          equals('+9191'),
        );

        expect(
          // this should keep the "441" prefix despite having local transform rules
          // because it is international
          PhoneNumber.parse('+14412957').nsn,
          equals('4412957'),
        );
      });

      test('should parse for caller', () {
        expect(
            PhoneNumber.parse('011 33 655 5705 76', callerCountry: IsoCode.US)
                .international,
            equals('+33655570576'));
        expect(
            PhoneNumber.parse('+33 655 5705 76', callerCountry: IsoCode.DE)
                .international,
            equals('+33655570576'));
        expect(
            PhoneNumber.parse('00 33 655 5705 76', callerCountry: IsoCode.FR)
                .international,
            equals('+33655570576'));
        expect(
            PhoneNumber.parse('810 33 655 5705 76', callerCountry: IsoCode.BY)
                .international,
            equals('+33655570576'));
        expect(
            PhoneNumber.parse('0 655 5705 76', callerCountry: IsoCode.FR)
                .international,
            equals('+33655570576'));
        expect(
            PhoneNumber.parse('0301234567', callerCountry: IsoCode.DE)
                .international,
            equals('+49301234567'));
        expect(
            PhoneNumber.parse('0049301234567', callerCountry: IsoCode.DE)
                .international,
            equals('+49301234567'));
        expect(
            PhoneNumber.parse('+49301234567', callerCountry: IsoCode.DE)
                .international,
            equals('+49301234567'));
      });

      test('should parse for destination', () {
        expect(
          PhoneNumber.parse(
            '301234567',
            destinationCountry: IsoCode.DE,
          ).international,
          equals('+49301234567'),
        );
      });

      test('should parse with raw phone number', () {
        PhoneNumber parse(n) => PhoneNumber.parse(n);
        // basic
        expect(PhoneNumber.parse('+32 479 995 533').isoCode, IsoCode.BE);
        expect(PhoneNumber.parse('+33655570500').international,
            equals('+33655570500'));

        // same country calling code
        expect(PhoneNumber.parse('+16135550165').isoCode, equals(IsoCode.CA));
        expect(PhoneNumber.parse('+12025550128').isoCode, equals(IsoCode.US));
        // no transform
        expect(parse('+54 9 343 555 1212').international,
            equals('+5493435551212'));
      });

      test(
          'should output a national number in its international version only when valid',
          () {
        expect(
            PhoneNumber.parse('0499 99 99 9', destinationCountry: IsoCode.BE)
                .nsn,
            equals('049999999'));
        expect(
            PhoneNumber.parse('0499 99 99 99', destinationCountry: IsoCode.BE)
                .nsn,
            equals('499999999'));
        // expect()
      });
    });

    group('Validity', () {
      test('Should give validity for version', () {
        for (var example in metadataExamplesByIsoCode.entries) {
          // kz has a faulty example
          if (example.key == IsoCode.KZ) continue;
          final parsed = PhoneNumber.parse(
            example.value.mobile,
            destinationCountry: example.key,
          );
          expect(
            parsed.isValid(),
            isTrue,
          );
          expect(
            PhoneNumber.parse(
              '${example.value.mobile}9999999',
              destinationCountry: example.key,
            ).isValid(),
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
    });

    test('validity', () {
      final gbValidLength =
          PhoneNumber.parse('0000000000', destinationCountry: IsoCode.GB);
      expect(gbValidLength.isValidLength(), isTrue);
      expect(gbValidLength.isValid(type: PhoneNumberType.mobile), isFalse);
      expect(gbValidLength.isValid(type: PhoneNumberType.fixedLine), isFalse);
      expect(gbValidLength.isValid(), isFalse);
      final gbValidPattern =
          PhoneNumber.parse('7111111111', destinationCountry: IsoCode.GB);
      expect(gbValidPattern.isValidLength(), isTrue);
      expect(gbValidPattern.isValid(), isTrue);
    });
  });

  group('format', () {
    test('should format', () {
      String format(String phoneNumber) =>
          PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.US)
              .getFormattedNsn();

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

    test('should format with another country format', () {
      String format(String phoneNumber) =>
          PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.US)
              .getFormattedNsn(isoCode: IsoCode.FR);

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
    });
  });

  group('range', () {
    test('count', () async {
      var zero = PhoneNumber.parse('61383208100');
      var one = PhoneNumber.parse('61383208101');
      var two = PhoneNumber.parse('61383208102');
      var ninenine = PhoneNumber.parse('61383208199');

      expect(PhoneNumberRange(zero, one).count, equals(2));
      expect(PhoneNumberRange(zero, two).count, equals(3));
      expect(PhoneNumberRange(two, zero).count, equals(3));

      expect(PhoneNumberRange(zero, ninenine).count, equals(100));
    });

    test('range', () async {
      var zero = PhoneNumber.parse('61383208100');
      var one = PhoneNumber.parse('61383208101');
      var two = PhoneNumber.parse('61383208102');
      var ninenine = PhoneNumber.parse('61383208199');

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
      var start = PhoneNumber.parse('61383208100');

      start = start + 1;
      expect(start, equals(PhoneNumber.parse('61383208101')));

      start = start - 1;
      expect(start, equals(PhoneNumber.parse('61383208100')));
    });

    test('comparision', () async {
      var zero = PhoneNumber.parse('61383208100');
      var one = PhoneNumber.parse('61383208101');

      expect(zero == zero, isTrue);
      expect(zero < one, isTrue);
      expect(zero <= one, isTrue);
      expect(zero > one, isFalse);
      expect(zero >= one, isFalse);
    });

    test('sequence', () async {
      var zero = PhoneNumber.parse('61383208100');
      var one = PhoneNumber.parse('61383208101');
      var two = PhoneNumber.parse('61383208102');

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
