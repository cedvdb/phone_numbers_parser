import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/_validator.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('_Validator', () {
    group('ValidateWithLength()', () {
      test('BE', () {
        final metadataBE = MetadataFinder.getLightMetadataForIsoCode('BE');
        final beValidMobilePhone = '479554265';
        final beInvalidMobilePhone = '4795542650';

        expect(Validator.validateWithLength(beValidMobilePhone, metadataBE),
            isTrue);
        expect(
            Validator.validateWithLength(
                beValidMobilePhone, metadataBE, PhoneNumberType.mobile),
            isTrue);
        // not a fixed line
        expect(
            Validator.validateWithLength(
                beValidMobilePhone, metadataBE, PhoneNumberType.fixedLine),
            isFalse);
        expect(Validator.validateWithLength(beInvalidMobilePhone, metadataBE),
            isFalse);
      });

      test('US', () {
        final metadataUS = MetadataFinder.getLightMetadataForIsoCode('US');
        final validUs = '2025550128';
        final invalidUs = '479554265';
        // invalid for US
        expect(Validator.validateWithLength(invalidUs, metadataUS), isFalse);
        expect(
            Validator.validateWithLength(
                invalidUs, metadataUS, PhoneNumberType.fixedLine),
            isFalse);
        expect(
            Validator.validateWithLength(
                invalidUs, metadataUS, PhoneNumberType.mobile),
            isFalse);
        // valid US
        expect(Validator.validateWithLength(validUs, metadataUS), isTrue);
        expect(
            Validator.validateWithLength(
                validUs, metadataUS, PhoneNumberType.fixedLine),
            isTrue);
        expect(
            Validator.validateWithLength(
                validUs, metadataUS, PhoneNumberType.mobile),
            isTrue);
        // invalid us
        expect(
            Validator.validateWithLength('20255501289', metadataUS), isFalse);
        expect(
            Validator.validateWithLength(
                '20255501289', metadataUS, PhoneNumberType.fixedLine),
            isFalse);
        expect(
            Validator.validateWithLength(
                '20255501289', metadataUS, PhoneNumberType.mobile),
            isFalse);
      });

      test('MY (Malaysia)', () {
        final metadata = MetadataFinder.getLightMetadataForIsoCode('MY');
        expect(Validator.validateWithLength('1112222444', metadata), isTrue);
      });
    });

    group('ValidateWithPattern()', () {
      test('BE', () {
        final metadataBE = MetadataFinder.getExtendedMetadataForIsoCode('BE');
        expect(
            Validator.validateWithPattern(
                '479889855', metadataBE, PhoneNumberType.mobile),
            isTrue);
        expect(
            Validator.validateWithPattern(
                '479889855', metadataBE, PhoneNumberType.fixedLine),
            isFalse);
      });

      test('CA', () {
        final metadataCA = MetadataFinder.getExtendedMetadataForIsoCode('CA');
        expect(
            Validator.validateWithPattern('7205754713', metadataCA), isFalse);
        expect(Validator.validateWithPattern('6135550165', metadataCA), isTrue);
      });

      test('US', () {
        final metadataUS = MetadataFinder.getExtendedMetadataForIsoCode('US');
        expect(Validator.validateWithPattern('7205754713', metadataUS), isTrue);

        expect(
            Validator.validateWithPattern('6135550165', metadataUS), isFalse);
      });
    });
  });
}
