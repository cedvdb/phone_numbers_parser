import 'package:phone_numbers_parser/src/models/country.dart';
import 'package:phone_numbers_parser/src/parsers/extractor.dart';
import 'package:test/test.dart';

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
      final france = '33 655 5705 76'.replaceAll(' ', '');
      final r0 = Extractor.extractDialCode(france);
      // dial codes do not begin by 0
      final r1 = Extractor.extractDialCode('0123456789');
      expect(r0.extracted, equals('33'));
      expect(r0.phoneNumber, equals('655570576'));
      expect(r1.extracted, equals(null));
      expect(r1.phoneNumber, equals('0123456789'));
    });

    test('Should extract national prefix', () {
      final france = Country.fromIsoCode('fr');
      final franceWithoutPrefix = '655 5705 76'.replaceAll(' ', '');
      final franceWithPrefix = '0' + franceWithoutPrefix;

      final fr1 = Extractor.extractNationalPrefix(franceWithoutPrefix, france);
      final fr2 = Extractor.extractNationalPrefix(franceWithPrefix, france);

      expect(fr1.extracted, equals(null));
      expect(fr1.phoneNumber, franceWithoutPrefix);

      expect(fr2.extracted, equals('0'));
      expect(fr2.phoneNumber, franceWithoutPrefix);
    });

    test('Should extract the country from the phone number', () {});

    test('Should extract the type of phone number', () {});
  });
}
