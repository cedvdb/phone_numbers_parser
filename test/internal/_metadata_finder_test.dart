import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_formats.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_lengths.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_patterns.dart';
import 'package:test/test.dart';

void main() {
  group('MetadataFinder', () {
    test('should get metadata for iso code', () {
      for (final isoCode in IsoCode.values) {
        expect(MetadataFinder.findMetadataForIsoCode(isoCode).isoCode,
            equals(isoCode));
      }
    });

    test('should get patterns metadata for iso code', () {
      for (final isoCode in IsoCode.values) {
        expect(MetadataFinder.findMetadataPatternsForIsoCode(isoCode),
            isA<PhoneMetadataPatterns>());
      }
    });

    test('should get lengths metadata for iso code', () {
      for (final isoCode in IsoCode.values) {
        expect(MetadataFinder.findMetadataLengthForIsoCode(isoCode),
            isA<PhoneMetadataLengths>());
      }
    });

    test('should get formats metadata for iso code', () {
      for (final isoCode in IsoCode.values) {
        expect(MetadataFinder.findMetadataFormatsForIsoCode(isoCode),
            isA<PhoneMetadataFormats>());
      }
    });

    test('should get formats metadata for iso code going through references',
        () {
      expect(MetadataFinder.findMetadataFormatsForIsoCode(IsoCode.CA),
          equals(MetadataFinder.findMetadataFormatsForIsoCode(IsoCode.US)));
    });

    test('should get metadata for country calling code', () {
      expect(MetadataFinder.findMetadataForCountryCode('33', '123456')?.isoCode,
          equals(IsoCode.FR));
      expect(
        MetadataFinder.findMetadataForCountryCode('1', '2025550128')?.isoCode,
        equals(IsoCode.US),
      );
      expect(
          MetadataFinder.findMetadataForCountryCode('1', '6135550165')?.isoCode,
          equals(IsoCode.CA));
    });
  });
}
