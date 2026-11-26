import 'package:phone_numbers_parser/metadata.dart';
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

    test('should expose lengths metadata under the corrected name', () {
      expect(
        metadataLengthsByIsoCode[IsoCode.FR],
        equals(MetadataFinder.findMetadataLengthForIsoCode(IsoCode.FR)),
      );
    });

    test('should keep the misspelled lengths metadata name as an alias', () {
      // ignore: deprecated_member_use_from_same_package
      expect(metadataLenghtsByIsoCode, equals(metadataLengthsByIsoCode));
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

    test('should match leadingDigits as a pattern, not as a literal prefix',
        () {
      // Isle of Man shares +44 and its leadingDigits are a pattern
      // (`74576|(?:16|7[56])24`), so a literal startsWith never matched it and
      // a number that is invalid in every +44 territory fell back to GB.
      expect(
        MetadataFinder.findMetadataForCountryCode('44', '1624123456')?.isoCode,
        equals(IsoCode.IM),
      );
      // the literal ones keep working
      expect(
        MetadataFinder.findMetadataForCountryCode('1', '6135550165')?.isoCode,
        equals(IsoCode.CA),
      );
      expect(
        MetadataFinder.findMetadataForCountryCode('7', '7051234567')?.isoCode,
        equals(IsoCode.KZ),
      );
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
