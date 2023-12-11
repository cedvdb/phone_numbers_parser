import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_validator.dart';
import 'package:test/test.dart';

void main() {
  group('_Validator', () {
    group('ValidateWithLength()', () {
      test('BR', () {
        final beValidMobilePhone = '31975228038';
        final beInvalidMobilePhone = '3175228038';
        expect(
          Validator.validateWithLength(
            IsoCode.BR,
            beValidMobilePhone,
            PhoneNumberType.mobile,
          ),
          isTrue,
        );
        expect(
            Validator.validateWithLength(
              IsoCode.BR,
              beInvalidMobilePhone,
              PhoneNumberType.mobile,
            ),
            isFalse);
      });
      test('BE', () {
        final beValidMobilePhone = '479554265';
        final beInvalidMobilePhone = '4795542650';

        expect(
          Validator.validateWithLength(
            IsoCode.BE,
            beValidMobilePhone,
          ),
          isTrue,
        );
        expect(
            Validator.validateWithLength(
              IsoCode.BE,
              beValidMobilePhone,
              PhoneNumberType.mobile,
            ),
            isTrue);
        // not a fixed line
        expect(
            Validator.validateWithLength(
              IsoCode.BE,
              beValidMobilePhone,
              PhoneNumberType.fixedLine,
            ),
            isFalse);
        // and not a general
        expect(
            Validator.validateWithLength(
              IsoCode.BE,
              beInvalidMobilePhone,
            ),
            isFalse);
      });

      test('US', () {
        final validUs = '2025550128';
        final invalidUs = '479554265';
        // invalid for US
        expect(Validator.validateWithLength(IsoCode.US, invalidUs), isFalse);
        expect(
            Validator.validateWithLength(
                IsoCode.US, invalidUs, PhoneNumberType.fixedLine),
            isFalse);
        expect(
            Validator.validateWithLength(
                IsoCode.US, invalidUs, PhoneNumberType.mobile),
            isFalse);
        // valid US
        expect(
            Validator.validateWithLength(
              IsoCode.US,
              validUs,
            ),
            isTrue);
        expect(
            Validator.validateWithLength(
                IsoCode.US, validUs, PhoneNumberType.fixedLine),
            isTrue);
        expect(
            Validator.validateWithLength(
                IsoCode.US, validUs, PhoneNumberType.mobile),
            isTrue);
      });

      test('zeroes', () {
        expect(
          Validator.validateWithLength(IsoCode.GB, '7000000002'),
          isTrue,
        );
      });
    });

    group('ValidateWithPattern()', () {
      test('BR', () {
        final validMobileBR = '31972727272';
        final invalidMobileBR = '3172727272';
        expect(
            Validator.validateWithPattern(
                IsoCode.BR, validMobileBR, PhoneNumberType.mobile),
            isTrue);
        expect(
            Validator.validateWithPattern(
                IsoCode.BR, invalidMobileBR, PhoneNumberType.mobile),
            isFalse);
      });
      test('BE', () {
        final validMobileBE = '479889855';
        final validFixedBE = '64223344';
        expect(
            Validator.validateWithPattern(
                IsoCode.BE, validMobileBE, PhoneNumberType.mobile),
            isTrue);
        expect(
            Validator.validateWithPattern(
                IsoCode.BE, validMobileBE, PhoneNumberType.fixedLine),
            isFalse);
        // fixed
        expect(
            Validator.validateWithPattern(
                IsoCode.BE, validFixedBE, PhoneNumberType.fixedLine),
            isTrue);
        expect(
            Validator.validateWithPattern(
                IsoCode.BE, validFixedBE, PhoneNumberType.mobile),
            isFalse);
      });

      test('CA', () {
        expect(
            Validator.validateWithPattern(IsoCode.CA, '7205754713'), isFalse);
        expect(Validator.validateWithPattern(IsoCode.CA, '6135550165'), isTrue);
      });

      test('US', () {
        expect(Validator.validateWithPattern(IsoCode.US, '7205754713'), isTrue);

        expect(
            Validator.validateWithPattern(IsoCode.US, '6135550165'), isFalse);
      });
    });
  });
}
