import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_matcher.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

void main() {
  group('MetadataMatcher', () {
    test('should reduce the list of potential metadata fits', () {
      final fits = MetadataFinder.getMetadatasForCountryCode('1');
      final nationalNumberWithLeadingDigits = '26811111111';
      final reduced = MetadataMatcher.reducePotentialMetadatasFits(
          nationalNumberWithLeadingDigits, fits);
      expect(reduced.length, equals(1));
      expect(reduced[0].isoCode, equals('AG'));
    });

    test('should find match based on pattern', () {
      expect(
        MetadataMatcher.getMatchUsingPatterns(
          '2025550128',
          MetadataFinder.getMetadatasForCountryCode('1'),
        ).isoCode,
        equals('US'),
      );
      expect(
        MetadataMatcher.getMatchUsingPatterns(
          '6135550165',
          MetadataFinder.getMetadatasForCountryCode('1'),
        ).isoCode,
        equals('CA'),
      );
    });
  });
}
