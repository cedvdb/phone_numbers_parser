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

      test('should remove the national prefix only once', () {
        // the national significant number itself starts with the digit of
        // the national prefix, removing it twice used to reject the number.
        void expectParse(String input, IsoCode isoCode, String international) {
          for (final parsed in [
            PhoneNumber.parse(input, callerCountry: isoCode),
            PhoneNumber.parse(input, destinationCountry: isoCode),
          ]) {
            expect(
              parsed.international,
              equals(international),
              reason: '$isoCode "$input"',
            );
            expect(
              parsed.isValid(),
              isTrue,
              reason: '$isoCode "$input"',
            );
          }
        }

        expectParse('8 800 555-35-35', IsoCode.RU, '+78005553535');
        expectParse('8 (812) 123-45-67', IsoCode.RU, '+78121234567');
        expectParse('8 801 234 5678', IsoCode.BY, '+3758012345678');
        expectParse('0 800 12345', IsoCode.LT, '+37080012345');
      });

      test('should parse a local number that needs a transform rule', () {
        // Argentina rewrites the national number: 0343 15 555 1212 (local) is
        // +54 9 343 555 1212 (international). The transform expects the
        // national prefix to be part of the number it is applied to.
        for (final parsed in [
          PhoneNumber.parse('0343 15 555 1212', callerCountry: IsoCode.AR),
          PhoneNumber.parse('0343 15 555 1212', destinationCountry: IsoCode.AR),
        ]) {
          expect(parsed.international, equals('+5493435551212'));
          expect(parsed.isValid(), isTrue);
        }
      });

      test('should remove the national prefix after a country code', () {
        // a number that contains a country code is already in its
        // international form: only the national prefix is removed after it,
        // the local transform is not applied.
        expect(
          PhoneNumber.parse('+7 8 800 555 35 35').international,
          equals('+78005553535'),
        );
        expect(
          PhoneNumber.parse('+375 8 801 234 5678').international,
          equals('+3758012345678'),
        );
        expect(
          PhoneNumber.parse('+370 0 800 12345').international,
          equals('+37080012345'),
        );
        expect(
          PhoneNumber.parse('+33 0 6 86 57 90 14').international,
          equals('+33686579014'),
        );
      });

      test('should not strip the national prefix twice on malformed input', () {
        // these only used to be valid because the prefix was removed twice.
        // libphonenumber rejects them too, so the digits are kept as typed.
        final doubled = PhoneNumber.parse(
          '8 8 800 555 35 35',
          callerCountry: IsoCode.RU,
        );
        expect(doubled.nsn, equals('888005553535'));
        expect(doubled.isValid(), isFalse);

        // in Colombia 0([3579]|4(?:[14]4|56))? is the national prefix for
        // parsing: a leading 0 before a mobile is read as a carrier code, it
        // is not a prefix that can simply be dropped.
        final colombian = PhoneNumber.parse(
          '03211234567',
          callerCountry: IsoCode.CO,
        );
        expect(colombian.nsn, equals('03211234567'));
        expect(colombian.isValid(), isFalse);
        expect(
          PhoneNumber.parse('3211234567', callerCountry: IsoCode.CO)
              .international,
          equals('+573211234567'),
        );
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
    test('should format with the international format by default', () {
      final us =
          PhoneNumber.parse('2025550119', destinationCountry: IsoCode.US);
      expect(us.format(), equals('+1 202-555-0119'));
      expect(
        us.format(format: PhoneNumberFormat.e164),
        equals('+12025550119'),
      );
      expect(
        us.format(format: PhoneNumberFormat.national),
        equals('(202) 555-0119'),
      );
    });

    test('should format with the national format when specified', () {
      String format(String phoneNumber) =>
          PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.US)
              .format(format: PhoneNumberFormat.national);

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
      // 7 digits match the local format rule, as in libphonenumber
      expect(format(testNumber), equals('202-5550'));
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
              .format(format: PhoneNumberFormat.international);

      var testNumber = '';
      expect(format(testNumber), equals(''));
      testNumber = '2';
      expect(format(testNumber), equals('+1 2'));
      testNumber = '20';
      expect(format(testNumber), equals('+1 20'));
      testNumber = '202';
      expect(format(testNumber), equals('+1 202'));
      testNumber = '2025';
      expect(format(testNumber), equals('+1 202-5'));
      testNumber = '20255';
      expect(format(testNumber), equals('+1 202-55'));
      testNumber = '202555';
      expect(format(testNumber), equals('+1 202-555'));
      testNumber = '2025550';
      expect(format(testNumber), equals('+1 202-5550'));
      testNumber = '20255501';
      expect(format(testNumber), equals('+1 202-555-01'));
      testNumber = '202555011';
      expect(format(testNumber), equals('+1 202-555-011'));
      testNumber = '2025550119';
      expect(format(testNumber), equals('+1 202-555-0119'));
    });

    test('should format as e164, international, national and nsn', () {
      final fr = PhoneNumber.parse('+33611223344');
      expect(
        fr.format(format: PhoneNumberFormat.e164),
        equals('+33611223344'),
      );
      expect(
        fr.format(format: PhoneNumberFormat.international),
        equals('+33 6 11 22 33 44'),
      );
      expect(
        fr.format(format: PhoneNumberFormat.national),
        equals('06 11 22 33 44'),
      );
      expect(fr.format(format: PhoneNumberFormat.nsn), equals('6 11 22 33 44'));

      // a country whose national format does not use the first group of the
      // pattern and needs a national prefix
      final ar = PhoneNumber.parse('+5492615325656');
      expect(
        ar.format(format: PhoneNumberFormat.e164),
        equals('+5492615325656'),
      );
      expect(
        ar.format(format: PhoneNumberFormat.international),
        equals('+54 9 261 532-5656'),
      );
      expect(
        ar.format(format: PhoneNumberFormat.national),
        equals('0261 15-532-5656'),
      );
      expect(
        ar.format(format: PhoneNumberFormat.nsn),
        equals('261 15-532-5656'),
      );

      // an empty nsn keeps the dial code in the international formats
      const empty = PhoneNumber(isoCode: IsoCode.FR, nsn: '');
      expect(
        empty.format(format: PhoneNumberFormat.e164),
        equals('+33'),
      );
      expect(empty.format(format: PhoneNumberFormat.national), equals(''));
    });

    test('should keep the deprecated formatNsn working', () {
      final phone = PhoneNumber.parse('+33611223344');
      // ignore: deprecated_member_use_from_same_package
      expect(
        phone.formatNsn(),
        equals(phone.format(format: PhoneNumberFormat.national)),
      );
      // ignore: deprecated_member_use_from_same_package
      expect(
        phone.formatNsn(format: NsnFormat.international),
        // NsnFormat.international was the grouped nsn, without the dial code
        equals(phone.format(format: PhoneNumberFormat.nsn)),
      );
    });

    test('should format with another country format', () {
      // the nsn is formatted with the rules of another country: the static
      // formatter is the entry point for that, a phone number is always
      // formatted as its own region.
      String format(String phoneNumber) => PhoneNumberFormatter.format(
            PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.US).nsn,
            IsoCode.FR,
            PhoneNumberFormat.national,
          );

      // the french national format starts with the national prefix
      var testNumber = '6';
      expect(format(testNumber), equals('06'));
      testNumber = '68';
      expect(format(testNumber), equals('06 8'));
      testNumber = '689';
      expect(format(testNumber), equals('06 89'));
      testNumber = '6895';
      expect(format(testNumber), equals('06 89 5'));
      testNumber = '68955';
      expect(format(testNumber), equals('06 89 55'));
      testNumber = '689555';
      expect(format(testNumber), equals('06 89 55 5'));
      testNumber = '6895555';
      expect(format(testNumber), equals('06 89 55 55'));
      testNumber = '68955555';
      expect(format(testNumber), equals('06 89 55 55 5'));
      testNumber = '689555555';
      expect(format(testNumber), equals('06 89 55 55 55'));
    });

    test('should format through a format reference', () {
      String format(String phoneNumber) =>
          PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.CA)
              .format(format: PhoneNumberFormat.national);

      var testNumber = '4185551212';
      expect(format(testNumber), equals('(418) 555-1212'));
    });

    test('should include the national prefix in the national format', () {
      // the national prefix is part of the national format, libphonenumber
      // formats these numbers the same way.
      String national(String nsn, IsoCode isoCode) => PhoneNumber(
            isoCode: isoCode,
            nsn: nsn,
          ).format(format: PhoneNumberFormat.national);

      expect(national('301234567', IsoCode.DE), equals('030 1234567'));
      expect(national('2079460958', IsoCode.GB), equals('020 7946 0958'));
      expect(national('611223344', IsoCode.FR), equals('06 11 22 33 44'));
      expect(national('12345678', IsoCode.BE), equals('012 34 56 78'));
      expect(national('8005553535', IsoCode.RU), equals('8 (800) 555-35-35'));
    });

    test('should not include the national prefix in the nsn format', () {
      String nsn(String nsn, IsoCode isoCode) => PhoneNumber(
            isoCode: isoCode,
            nsn: nsn,
          ).format(format: PhoneNumberFormat.nsn);

      expect(nsn('301234567', IsoCode.DE), equals('30 1234567'));
      expect(nsn('2079460958', IsoCode.GB), equals('20 7946 0958'));
      expect(
        nsn('8005553535', IsoCode.RU),
        equals('800 555-35-35'),
      );
    });

    test('should format without the national prefix when asked', () {
      // same grouping as the national format, without the prefix: this is what
      // a text field shows when the dial code is displayed next to it.
      String withoutPrefix(String nsn, IsoCode isoCode) => PhoneNumber(
            isoCode: isoCode,
            nsn: nsn,
          ).format(format: PhoneNumberFormat.nsn);

      expect(withoutPrefix('477889922', IsoCode.BE), equals('477 88 99 22'));
      expect(withoutPrefix('611223344', IsoCode.FR), equals('6 11 22 33 44'));
      expect(withoutPrefix('8005553535', IsoCode.RU), equals('800 555-35-35'));
      expect(
        withoutPrefix('92615325656', IsoCode.AR),
        equals('261 15-532-5656'),
      );
    });

    test('should prefer the format that matches the number as it is', () {
      // 14020 is a dutch short number: it matches the 14 rule and must not be
      // padded to a full number before being formatted.
      expect(
        PhoneNumber(isoCode: IsoCode.NL, nsn: '14020')
            .format(format: PhoneNumberFormat.national),
        equals('14 020'),
      );
    });

    test('should not pad a number that matches a format as it is', () {
      // these numbers are complete and match a format as they are, but they
      // are shorter than the minimum mobile length of their country. Padding
      // them changes how the groups of a `{2,3}` pattern split.
      String national(String nsn, IsoCode isoCode) => PhoneNumber(
            isoCode: isoCode,
            nsn: nsn,
          ).format(format: PhoneNumberFormat.national);
      String international(String nsn, IsoCode isoCode) => PhoneNumber(
            isoCode: isoCode,
            nsn: nsn,
          ).format(format: PhoneNumberFormat.international);

      expect(national('8123456', IsoCode.SE), equals('08-12 34 56'));
      expect(international('8123456', IsoCode.SE), equals('+46 8 12 34 56'));
      expect(national('20123456', IsoCode.SE), equals('020-12 34 56'));
      expect(national('22123456', IsoCode.KR), equals('02-212-3456'));
      expect(national('800123456', IsoCode.BR), equals('0800 12 3456'));
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
  group(
      'format national phone number if transformRule does not start with \$1. example: (\$2 15-\$3-\$4)(AR)',
      () {
    test('should format argentinian phone numbers', () {
      String format(String phoneNumber) =>
          PhoneNumber.parse(phoneNumber, destinationCountry: IsoCode.AR)
              .format(format: PhoneNumberFormat.national);
      var testNumber = '';
      expect(format(testNumber), equals(''));
      testNumber = '5';
      expect(format(testNumber), equals('5'));
      testNumber = '54';
      expect(format(testNumber), equals('54'));
      testNumber = '549';
      expect(format(testNumber), equals('549'));
      testNumber = '5492';
      expect(format(testNumber), equals('5492'));
      testNumber = '54926';
      expect(format(testNumber), equals('54926'));
      testNumber = '549261';
      // 6 digits match the short format rule, as in libphonenumber
      expect(format(testNumber), equals('54-9261'));
      testNumber = '5492615';
      expect(format(testNumber), equals('549-2615'));
      testNumber = '54926153';
      expect(format(testNumber), equals('5492-6153'));
      testNumber = '549261532';
      expect(format(testNumber), equals('549261532'));
      testNumber = '5492615325';
      expect(format(testNumber), equals('5492615325'));

      testNumber = '54926153256';
      expect(format(testNumber), equals('54926153256'));
      testNumber = '549261532565';
      expect(format(testNumber), equals('549261532565'));
      testNumber = '5492615325656';
      // the national format is prefixed with the national prefix, which is
      // spliced in place of the first group used by the format ($2 here).
      expect(format(testNumber), equals('0261 15-532-5656'));
      testNumber = '+5492615325656';
      expect(format(testNumber), equals('0261 15-532-5656'));
      testNumber = '54 9 261-5325 656';
      expect(format(testNumber), equals('0261 15-532-5656'));
      testNumber = '54-9-261-5325-656';
      expect(format(testNumber), equals('0261 15-532-5656'));
      testNumber = '54.9.261.5325.656';
      expect(format(testNumber), equals('0261 15-532-5656'));
    });
  });
  test('Invalid phone number throws exception', () {
    expect(
      () => PhoneNumber.parse('bad'),
      throwsA(
        allOf([
          isA<Exception>(),
          isA<PhoneNumberException>()
              .having((e) => e.code, 'code', Code.invalid),
        ]),
      ),
    );
  });

  group('robustness', () {
    /// A phone number can never exceed the maximum country calling code length
    /// plus the maximum national significant number length (3 + 17 = 20).
    const maxDigits = 20;

    test('throws inputIsTooLong for an excessive amount of digits', () {
      final tooLong = '1${'2' * (maxDigits + 5)}';
      expect(
        () => PhoneNumber.parse(tooLong, callerCountry: IsoCode.US),
        throwsA(
          isA<PhoneNumberException>()
              .having((e) => e.code, 'code', Code.inputIsTooLong),
        ),
      );
    });

    test('does not throw for a number at the maximum length', () {
      final atMax = '1${'2' * (maxDigits - 1)}';
      expect(atMax.length, equals(maxDigits));
      expect(
        () => PhoneNumber.parse(atMax, callerCountry: IsoCode.US),
        returnsNormally,
      );
    });

    test('throws invalid when the input contains no digits', () {
      expect(
        () => PhoneNumber.parse('not a phone number'),
        throwsA(
          isA<PhoneNumberException>()
              .having((e) => e.code, 'code', Code.invalid),
        ),
      );
    });

    test('does not throw when no digits are provided but a country is known',
        () {
      // this is important for progressive input where the text is emptied
      expect(
        () => PhoneNumber.parse('', destinationCountry: IsoCode.AR),
        returnsNormally,
      );
    });
  });
}
