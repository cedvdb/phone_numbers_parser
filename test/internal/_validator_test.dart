import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/_validator.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('_Validator', () {
    test('should validate with length', () {
      final metadataBE = MetadataFinder.getLightMetadataForIsoCode('BE');
      final metadataUS = MetadataFinder.getLightMetadataForIsoCode('US');
      final beMobilePhone = '479554265';

      expect(Validator.validateWithLength(beMobilePhone, metadataBE),
          equals(true));
      expect(
          Validator.validateWithLength(
              beMobilePhone, metadataBE, PhoneNumberType.mobile),
          equals(true));
      // not a fixed line
      expect(
          Validator.validateWithLength(
              beMobilePhone, metadataBE, PhoneNumberType.fixedLine),
          equals(false));
      // invalid for US
      expect(Validator.validateWithLength(beMobilePhone, metadataUS),
          equals(false));
      expect(
          Validator.validateWithLength(
              beMobilePhone, metadataUS, PhoneNumberType.fixedLine),
          equals(false));
      expect(
          Validator.validateWithLength(
              beMobilePhone, metadataUS, PhoneNumberType.mobile),
          equals(false));
      // valid US
      expect(
          Validator.validateWithLength('2025550128', metadataUS), equals(true));
      expect(
          Validator.validateWithLength(
              '2025550128', metadataUS, PhoneNumberType.fixedLine),
          equals(true));
      expect(
          Validator.validateWithLength(
              '2025550128', metadataUS, PhoneNumberType.mobile),
          equals(true));
      // invalid us
      expect(Validator.validateWithLength('20255501289', metadataUS),
          equals(false));
      expect(
          Validator.validateWithLength(
              '20255501289', metadataUS, PhoneNumberType.fixedLine),
          equals(false));
      expect(
          Validator.validateWithLength(
              '20255501289', metadataUS, PhoneNumberType.mobile),
          equals(false));
    });

    test('should validate with pattern', () {
      final metadataUS = MetadataFinder.getExtendedMetadataForIsoCode('US');
      final metadataCA = MetadataFinder.getExtendedMetadataForIsoCode('CA');
      final metadataBE = MetadataFinder.getExtendedMetadataForIsoCode('BE');
      // valid us
      expect(Validator.validateWithPattern('7205754713', metadataUS),
          equals(true));
      expect(Validator.validateWithPattern('7205754713', metadataCA),
          equals(false));
      // valid CA
      expect(Validator.validateWithPattern('6135550165', metadataUS),
          equals(false));
      expect(Validator.validateWithPattern('6135550165', metadataCA),
          equals(true));
      // mobile vs fixed line
      expect(
          Validator.validateWithPattern(
              '479889855', metadataBE, PhoneNumberType.mobile),
          equals(true));
      expect(
          Validator.validateWithPattern(
              '479889855', metadataBE, PhoneNumberType.fixedLine),
          equals(false));
    });
  });
}
