import 'package:phone_numbers_parser/metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/validation/validator.dart';
import 'package:test/test.dart';

void main() {
  group('_Validator', () {
    group('ValidateWithLength()', () {
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

      // Portugal supports all phone types
      test('PT', () {
        final isoCode = IsoCode.PT;
        final examples = metadataExamplesByIsoCode[isoCode]!;
        expect(
          Validator.validateWithLength(
            isoCode,
            examples.mobile,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.mobile,
            PhoneNumberType.mobile,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.fixedLine,
            PhoneNumberType.fixedLine,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.voip,
            PhoneNumberType.voip,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.tollFree,
            PhoneNumberType.tollFree,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.premiumRate,
            PhoneNumberType.premiumRate,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.sharedCost,
            PhoneNumberType.sharedCost,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.personalNumber,
            PhoneNumberType.personalNumber,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.uan,
            PhoneNumberType.uan,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.pager,
            PhoneNumberType.pager,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.voiceMail,
            PhoneNumberType.voiceMail,
          ),
          isTrue,
        );
      });

      // Italy has different lengths for different formats
      test('IT', () {
        final isoCode = IsoCode.IT;
        final examples = metadataExamplesByIsoCode[isoCode]!;
        expect(
          Validator.validateWithLength(
            isoCode,
            examples.sharedCost, // Can be 6 or 9
            PhoneNumberType.voip, // Can be 10
          ),
          isFalse,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.voip, // Can be 10
            PhoneNumberType.sharedCost, // Can be 6 or 9
          ),
          isFalse,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.voiceMail, // Can be 11 or 12
            PhoneNumberType.personalNumber, // Can be 9 or 10
          ),
          isFalse,
        );

        expect(
          Validator.validateWithLength(
            isoCode,
            examples.personalNumber, // Can be 9 or 10
            PhoneNumberType.voiceMail, // Can be 11 or 12
          ),
          isFalse,
        );
      });
    });

    group('ValidateWithPattern()', () {
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

      // Portugal supports all phone types
      test('PT', () {
        final isoCode = IsoCode.PT;
        final examples = metadataExamplesByIsoCode[isoCode]!;
        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.mobile,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.mobile,
            PhoneNumberType.mobile,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.fixedLine,
            PhoneNumberType.fixedLine,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.voip,
            PhoneNumberType.voip,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.tollFree,
            PhoneNumberType.tollFree,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.premiumRate,
            PhoneNumberType.premiumRate,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.sharedCost,
            PhoneNumberType.sharedCost,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.personalNumber,
            PhoneNumberType.personalNumber,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.uan,
            PhoneNumberType.uan,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.pager,
            PhoneNumberType.pager,
          ),
          isTrue,
        );

        expect(
          Validator.validateWithPattern(
            isoCode,
            examples.voiceMail,
            PhoneNumberType.voiceMail,
          ),
          isTrue,
        );
      });
    });
  });
}
