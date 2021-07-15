import 'package:phone_numbers_parser/src/parsers/extractor.dart';
import 'package:test/test.dart';

import '../test_data.dart';

void main() {
  group('Extractor', () {
    test('should extract international prefix', () {
      final expected = '33456';
      final r0 = Extractor.extractInternationalPrefix('+' + expected);
      final r1 = Extractor.extractInternationalPrefix('00' + expected);
      final r2 = Extractor.extractInternationalPrefix('011' + expected);
      final r3 = Extractor.extractInternationalPrefix(expected);
      expect(r0.phoneNumber, equals(expected));
      expect(r0.extracted, equals('+'));
      expect(r1.phoneNumber, equals(expected));
      expect(r1.extracted, equals('00'));
      expect(r2.phoneNumber, equals(expected));
      expect(r2.extracted, equals('011'));
      expect(r3.phoneNumber, equals(expected));
      expect(r3.extracted, equals(null));
    });

    test('should extract dial code', () {
      final france = '339999';
      final r0 = Extractor.extractDialCode(france);
      // dial codes do not begin by 0
      final r1 = Extractor.extractDialCode('0123456789');
      expect(r0.extracted, equals('33'));
      expect(r0.phoneNumber, equals('9999'));
      expect(r1.extracted, equals(null));
      expect(r1.phoneNumber, equals('0123456789'));
    });

    test('Should extract national prefix', () {
      testData.forEach((element) {
        final transformed = Extractor.extractNationalPrefix(
            element.nationalLocal, element.country);
        expect(transformed.phoneNumber, equals(element.nsn));
        expect(transformed.extracted,
            equals(element.country.phoneDescription.nationalPrefix));
      });
    });

    test('Should extract the country from the phone number', () {
      testData.forEach((element) {
        final result1 = Extractor.extractIsoCode(
            element.nationalLocal, element.country.dialCode);
        final result2 =
            Extractor.extractIsoCode(element.nsn, element.country.dialCode);
        expect(result1.extracted, equals(element.country));
        expect(result2.extracted, equals(element.country));
      });
    });
  });
}
