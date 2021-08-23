import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/_validator.dart';
import 'package:test/test.dart';

void main() {
  group('_Validator', () {
    group('ValidateWithLength()', () {
      test('BE', () {
        final BE = 'BE';
        final beValidMobilePhone = '479554265';
        final beInvalidMobilePhone = '4795542650';

        expect(
          Validator.validateWithLength(
            PhoneNumber(nsn: beValidMobilePhone, isoCode: BE),
          ),
          isTrue,
        );
        expect(
            Validator.validateWithLength(
                PhoneNumber(nsn: beValidMobilePhone, isoCode: BE),
                PhoneNumberType.mobile),
            isTrue);
        // not a fixed line
        expect(
            Validator.validateWithLength(
                PhoneNumber(nsn: beValidMobilePhone, isoCode: BE),
                PhoneNumberType.fixedLine),
            isFalse);
        // and not a general
        expect(
            Validator.validateWithLength(
              PhoneNumber(nsn: beInvalidMobilePhone, isoCode: BE),
            ),
            isFalse);
      });

      test('US', () {
        final US = 'US';
        final validUs = '2025550128';
        final invalidUs = '479554265';
        // invalid for US
        expect(
            Validator.validateWithLength(
              PhoneNumber(nsn: invalidUs, isoCode: US),
            ),
            isFalse);
        expect(
            Validator.validateWithLength(
                PhoneNumber(nsn: invalidUs, isoCode: US),
                PhoneNumberType.fixedLine),
            isFalse);
        expect(
            Validator.validateWithLength(
                PhoneNumber(nsn: invalidUs, isoCode: US),
                PhoneNumberType.mobile),
            isFalse);
        // valid US
        expect(
            Validator.validateWithLength(
                PhoneNumber(nsn: validUs, isoCode: US)),
            isTrue);
        expect(
            Validator.validateWithLength(PhoneNumber(nsn: validUs, isoCode: US),
                PhoneNumberType.fixedLine),
            isTrue);
        expect(
            Validator.validateWithLength(
                PhoneNumber(nsn: validUs, isoCode: US), PhoneNumberType.mobile),
            isTrue);
      });
    });

    group('ValidateWithPattern()', () {
      test('BE', () {
        final BE = 'BE';
        final validMobileBE = '479889855';
        final validFixedBE = '64223344';
        expect(
            Validator.validateWithPattern(
                PhoneNumber(isoCode: BE, nsn: validMobileBE),
                PhoneNumberType.mobile),
            isTrue);
        expect(
            Validator.validateWithPattern(
                PhoneNumber(isoCode: BE, nsn: validMobileBE),
                PhoneNumberType.fixedLine),
            isFalse);
        // fixed
        expect(
            Validator.validateWithPattern(
                PhoneNumber(isoCode: BE, nsn: validFixedBE),
                PhoneNumberType.fixedLine),
            isTrue);
        expect(
            Validator.validateWithPattern(
                PhoneNumber(isoCode: BE, nsn: validFixedBE),
                PhoneNumberType.mobile),
            isFalse);
      });

      test('CA', () {
        final CA = 'CA';
        expect(
            Validator.validateWithPattern(
              PhoneNumber(isoCode: CA, nsn: '7205754713'),
            ),
            isFalse);
        expect(
            Validator.validateWithPattern(
                PhoneNumber(isoCode: CA, nsn: '6135550165')),
            isTrue);
      });

      test('US', () {
        final US = 'US';
        expect(
            Validator.validateWithPattern(
              PhoneNumber(isoCode: US, nsn: '7205754713'),
            ),
            isTrue);

        expect(
            Validator.validateWithPattern(
                PhoneNumber(isoCode: US, nsn: '6135550165')),
            isFalse);
      });
    });
  });
}
