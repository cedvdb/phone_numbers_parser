import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:phone_numbers_parser/src/metadata/metadata_matcher.dart';
import 'package:test/test.dart';

void main() {
  group('MetadataMatcher', () {
    test('should find match based on pattern', () {
      expect(
        MetadataMatcher.getMatchUsingPatterns(
          '2025550128',
          MetadataFinder.getMetadatasForCountryCode('1'),
        ).isoCode,
        equals(IsoCode.US),
      );
      expect(
        MetadataMatcher.getMatchUsingPatterns(
          '6135550165',
          MetadataFinder.getMetadatasForCountryCode('1'),
        ).isoCode,
        equals(IsoCode.CA),
      );
    });
  });
}
