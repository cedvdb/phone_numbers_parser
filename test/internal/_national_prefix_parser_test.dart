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
