import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_number_parser.dart';
import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('_NationalPrefixParser', () {
    test('should remove nationalPrefix', () {
      final metadataFR = MetadataFinder.findMetadataForIsoCode(IsoCode.FR);
      final remove = NationalNumberParser.extractNationalPrefix;
      expect(remove('0488991144', metadataFR), equals(('0', '488991144')));
    });

    test('should remove remove nationalPrefix and transform', () {
      // in argentina 0343 15 555 1212 (local) is exactly the
      // number as +54 9 343 555 1212 (international)
      final metadataAR = MetadataFinder.findMetadataForIsoCode(IsoCode.AR);
      final tr =
          NationalNumberParser.transformLocalNsnToInternationalUsingPatterns;
      expect(tr('0343155551212', metadataAR), equals('93435551212'));
    });

    test('should expect the national prefix to be part of the number', () {
      // the transform removes the national prefix itself. Removing it before
      // calling it strips a digit of the nsn when the nsn starts with the
      // prefix digit, which is what used to reject RU 8 800 numbers.
      final metadataRU = MetadataFinder.findMetadataForIsoCode(IsoCode.RU);
      final tr =
          NationalNumberParser.transformLocalNsnToInternationalUsingPatterns;
      expect(tr('88005553535', metadataRU), equals('8005553535'));
      expect(tr('8005553535', metadataRU), equals('005553535'));
    });

    test('should strip the national prefix and the carrier code in one pass',
        () {
      // Colombia's nationalPrefixForParsing is 0([3579]|4(?:[14]4|56))?: the
      // digit after the 0 is a carrier code and is removed with the prefix.
      final metadataCO = MetadataFinder.findMetadataForIsoCode(IsoCode.CO);
      final tr =
          NationalNumberParser.transformLocalNsnToInternationalUsingPatterns;
      expect(tr('03211234567', metadataCO), equals('211234567'));
      expect(tr('3211234567', metadataCO), equals('3211234567'));
    });

    group('applyTransformRules', () {
      test('should return the input untouched when the pattern does not match',
          () {
        expect(
          NationalNumberParser.applyTransformRules(
            appliedTo: '123456',
            pattern: r'^99',
            transformRule: r'9$1',
          ),
          equals('123456'),
        );
      });

      test('should only strip the match when there is no transform rule', () {
        expect(
          NationalNumberParser.applyTransformRules(
            appliedTo: '0123',
            pattern: r'0',
            transformRule: null,
          ),
          equals('123'),
        );
      });

      test('should replace the group references', () {
        expect(
          NationalNumberParser.applyTransformRules(
            appliedTo: '0123456',
            pattern: r'0(\d+)',
            transformRule: r'$1',
          ),
          equals('123456'),
        );
        expect(
          NationalNumberParser.applyTransformRules(
            appliedTo: '01123456',
            pattern: r'0?(11|2\d+)',
            transformRule: r'9$1',
          ),
          equals('91123456'),
        );
      });

      test('should replace multi digit group references (regression: \$1\$10)',
          () {
        // a naive lowest-first replacement would turn `$10` into `<group1>0`.
        expect(
          NationalNumberParser.applyTransformRules(
            appliedTo: 'abcdefghij',
            pattern: r'^(a)(b)(c)(d)(e)(f)(g)(h)(i)(j)',
            transformRule: r'$10-$2',
          ),
          equals('j-b'),
        );
        // the first group must still be replaced
        expect(
          NationalNumberParser.applyTransformRules(
            appliedTo: 'abcdefghij',
            pattern: r'^(a)(b)(c)(d)(e)(f)(g)(h)(i)(j)',
            transformRule: r'$1$10',
          ),
          equals('aj'),
        );
      });

      test('should leave references to a missing group untouched', () {
        expect(
          NationalNumberParser.applyTransformRules(
            appliedTo: 'a',
            pattern: r'^(a)(1)?',
            transformRule: r'$1$2',
          ),
          equals(r'a$2'),
        );
      });
    });
  });
}
