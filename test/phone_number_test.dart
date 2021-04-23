import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

// this test file is to explain the public api,
// other test files in internal are more complete
//
void main() {
  const isoCode = 'FR';
  const internationalInput = '+33 655 5705 76';
  const internationalResult = '+33655570576';
  const localInput = '0 655 5705 76';
  const nsnResult = '655570576';

  group('PhoneNumber', () {
    group('fromIsoCode', () {
      test('should create', () {
        final francePhone = PhoneNumber.fromIsoCode('fr', localInput);
        expect(francePhone.isoCode, equals(isoCode));
        expect(francePhone.nsn, equals(nsnResult));
        expect(francePhone.international, equals(internationalResult));
      });

      test('should not throw error for empty input when country is valid', () {
        expect(PhoneNumber.fromIsoCode('fr', ''), TypeMatcher<PhoneNumber>());
      });

      test('should throw error when country is invalid', () {
        expect(
          () => PhoneNumber.fromIsoCode('not found', ''),
          throwsA(TypeMatcher<PhoneNumberException>()),
        );
      });
    });

    group('fromDialCode', () {
      test('should create', () {
        final francePhone = PhoneNumber.fromDialCode('33', localInput);
        expect(francePhone.isoCode, equals(isoCode));
        expect(francePhone.nsn, equals(nsnResult));
        expect(francePhone.international, equals(internationalResult));
      });

      test('should not throw error for empty input when country is valid', () {
        expect(PhoneNumber.fromDialCode('1', ''), TypeMatcher<PhoneNumber>());
      });

      test('should throw error when country is invalid', () {
        expect(
          () => PhoneNumber.fromDialCode('0', ''),
          throwsA(TypeMatcher<PhoneNumberException>()),
        );
      });
    });

    group('fromRaw', () {
      test('should create', () {
        final francePhone = PhoneNumber.fromRaw(internationalInput);
        expect(francePhone.isoCode, equals(isoCode));
        expect(francePhone.nsn, equals(nsnResult));
        expect(francePhone.international, equals(internationalResult));
      });

      test('should throw error for empty input', () {
        expect(() => PhoneNumber.fromRaw(''),
            throwsA(TypeMatcher<PhoneNumberException>()));
      });
    });

    group('validity', () {
      test('should validate for type', () {
        final frMobile = PhoneNumber.fromRaw('+33 655 5705 76');
        expect(frMobile.validate(null), equals(true));
        expect(frMobile.validate(PhoneNumberType.fixedLine), equals(false));
        expect(frMobile.validate(PhoneNumberType.mobile), equals(true));
        final frFix = PhoneNumber.fromRaw('+33 1 40 71 87 28');
        expect(frFix.validate(null), equals(true));
        expect(frFix.validate(PhoneNumberType.fixedLine), equals(true));
        expect(frFix.validate(PhoneNumberType.mobile), equals(false));
      });
    });

    test('copyWithIsoCode', () {
      final frPhone = PhoneNumber.fromRaw('+33 655 5705 76');
      expect(frPhone.isoCode, equals('FR'));
      expect(frPhone.international, equals('+33655570576'));
      final esPhone = frPhone.copyWithIsoCode('ES');
      expect(esPhone.dialCode, equals('34'));
      expect(esPhone.isoCode, equals('ES'));
      expect(esPhone.international, equals('+34655570576'));

      // the transformation of the national number should be unapplied
      final argentinaNationalLocal = '0343155551212';
      final phoneNumberAg =
          PhoneNumber.fromIsoCode('ag', argentinaNationalLocal);
      final phoneNumberCopy = phoneNumberAg.copyWithIsoCode('FR');
      // here we see that the argentinian nsn is not equals to just the zero
      // removed and we see that the french copy is
      expect(phoneNumberAg.nsn,
          isNot(equals(argentinaNationalLocal.substring(1))));
      expect(phoneNumberCopy.isoCode, equals('FR'));
      expect(phoneNumberCopy.nsn, equals(argentinaNationalLocal.substring(1)));
    });

    // just a quick test to copy paste in the readme for giving an overview of
    // the api
    test('readme example', () {
      final frPhone = PhoneNumber.fromRaw('+33 655 5705 76');
      final frPhone1 = PhoneNumber.fromIsoCode('fr', '655 5705 76');
      final frPhone2 = PhoneNumber.fromDialCode('33', '655 5705 76');
      final frPhone3 = PhoneNumber.fromIsoCode('fr', '0655 5705 76');
      final international = frPhone.international;
      expect(international, equals('+33655570576'));
      final allInternationalEqual = international == frPhone1.international &&
          international == frPhone2.international &&
          international == frPhone3.international;
      expect(allInternationalEqual, equals(true));
      expect(frPhone.dialCode, equals('33'));
      expect(frPhone.isoCode, equals('FR'));
      expect(frPhone.validate(PhoneNumberType.fixedLine), equals(false));
      expect(frPhone.validate(PhoneNumberType.mobile), equals(true));
      final esPhone = frPhone.copyWithIsoCode('ES');
      expect(esPhone.dialCode, equals('34'));
      expect(esPhone.isoCode, equals('ES'));
      expect(esPhone.international, equals('+34655570576'));
      expect(frPhone.validate(PhoneNumberType.fixedLine), equals(false));
      expect(frPhone.validate(PhoneNumberType.mobile), equals(true));
    });
  });
}
