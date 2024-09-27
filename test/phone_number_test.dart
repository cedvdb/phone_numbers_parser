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
            PhoneNumber.parse('09 67 49 76 70', callerCountry: IsoCode.FR)
                .international,
            equals('+33967497670'));
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
        expect(PhoneNumber.parse('+33 9 67 49 76 70').isoCode, IsoCode.FR);
        expect(PhoneNumber.parse('+33655570500').international,
            equals('+33655570500'));
        expect(PhoneNumber.parse('+33967497670').international,
            equals('+33967497670'));

        // same country calling code
        expect(PhoneNumber.parse('+16135550165').isoCode, equals(IsoCode.CA));
        expect(PhoneNumber.parse('+12025550128').isoCode, equals(IsoCode.US));
        // no transform
        expect(parse('+54 9 343 555 1212').international,
            equals('+5493435551212'));
      });

      test(
          'should parse local numbers w/o national prefix as they belong to caller country',
          () {
        expect(
            PhoneNumber.parse('(888) 555-5512', callerCountry: IsoCode.US)
                .international,
            equals('+18885555512'));
        expect(
            PhoneNumber.parse('(555) 522-8243', callerCountry: IsoCode.US)
                .international,
            equals('+15555228243'));
        expect(
            PhoneNumber.parse('(707) 555-1854', callerCountry: IsoCode.US)
                .international,
            equals('+17075551854'));
      });

      test(
          'should parse phone numbers without exit code but with a country code if caller or destination country is provided',
          () async {
        // issue https://github.com/cedvdb/phone_numbers_parser/issues/39
        var expected = '+64211234567';
        testParse(String phoneNumber) {
          expect(
            PhoneNumber.parse(
              phoneNumber,
              destinationCountry: IsoCode.NZ,
            ).international,
            expected,
          );
          expect(
            PhoneNumber.parse(
              phoneNumber,
              callerCountry: IsoCode.NZ,
            ).international,
            expected,
          );
          expect(
            PhoneNumber.parse(
              phoneNumber,
              destinationCountry: IsoCode.NZ,
              callerCountry: IsoCode.NZ,
            ).international,
            expected,
          );
        }

        // (with exit code)
        testParse('021 123 4567');
        testParse('+640211234567');
        testParse('+64211234567');
        // (just nsn)
        testParse('211234567');
        testParse('21 1234 567');
        // Actual test: no exit code but starts with country code
        // it should remove the country code if it is valid without.
        expect(
          PhoneNumber(isoCode: IsoCode.NZ, nsn: '211234567').isValid(),
          isTrue,
        );
        expect(
          PhoneNumber(isoCode: IsoCode.NZ, nsn: '64211234567').isValid(),
          isFalse,
        );
        testParse('640211234567');
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
      expect(gbValidLength.isValid(type: PhoneNumberType.voip), isFalse);
      expect(gbValidLength.isValid(type: PhoneNumberType.tollFree), isFalse);
      expect(gbValidLength.isValid(type: PhoneNumberType.premiumRate), isFalse);
      expect(gbValidLength.isValid(type: PhoneNumberType.sharedCost), isFalse);
      expect(
        gbValidLength.isValid(type: PhoneNumberType.personalNumber),
        isFalse,
      );
      expect(gbValidLength.isValid(type: PhoneNumberType.uan), isFalse);
      expect(gbValidLength.isValid(type: PhoneNumberType.pager), isFalse);
      expect(gbValidLength.isValid(type: PhoneNumberType.voiceMail), isFalse);
      expect(gbValidLength.isValid(), isFalse);
      final gbValidPattern =
          PhoneNumber.parse('7111111111', destinationCountry: IsoCode.GB);
      expect(gbValidPattern.isValidLength(), isTrue);
      expect(gbValidPattern.isValid(), isTrue);
    });
  });

  group('format', () {
    test('should format with the national format by default', () {
      String format(String phoneNumber) =>
          PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.US)
              .formatNsn();

      var testNumber = '';
      expect(format(testNumber), equals(''));
      testNumber = '2';
      expect(format(testNumber), equals('(2'));
      testNumber = '20';
      expect(format(testNumber), equals('(20'));
      testNumber = '202';
      expect(format(testNumber), equals('(202)'));
      testNumber = '2025';
      expect(format(testNumber), equals('(202) 5'));
      testNumber = '20255';
      expect(format(testNumber), equals('(202) 55'));
      testNumber = '202555';
      expect(format(testNumber), equals('(202) 555'));
      testNumber = '2025550';
      expect(format(testNumber), equals('(202) 555-0'));
      testNumber = '20255501';
      expect(format(testNumber), equals('(202) 555-01'));
      testNumber = '202555011';
      expect(format(testNumber), equals('(202) 555-011'));
      testNumber = '2025550119';
      expect(format(testNumber), equals('(202) 555-0119'));
    });

    test('should format with the international format when specified', () {
      String format(String phoneNumber) =>
          PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.US)
              .formatNsn(format: NsnFormat.international);

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
              .formatNsn(isoCode: IsoCode.FR);

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

    test('should format through a format reference', () {
      String format(String phoneNumber) =>
          PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.CA)
              .formatNsn(isoCode: IsoCode.CA);

      var testNumber = '4185551212';
      expect(format(testNumber), equals('(418) 555-1212'));
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
