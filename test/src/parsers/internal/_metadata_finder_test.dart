import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('MetadataFinder', () {
    test('should get metadata for iso code', () {
      expect(MetadataFinder.getMetadataForIsoCode(IsoCode.US).isoCode, equals(IsoCode.US));
    });

    test('should get patterns metadata for iso code', () {
      expect(MetadataFinder.getMetadataPatternsForIsoCode(IsoCode.US),
          isA<PhoneMetadataPatterns>());
    });

    test('should get lengths metadata for iso code', () {
      expect(MetadataFinder.getMetadataLengthForIsoCode(IsoCode.US),
          isA<PhoneMetadataLengths>());
    });

    test('should get formats metadata for iso code', () {
      expect(MetadataFinder.getMetadataFormatsForIsoCode(IsoCode.US),
          isA<PhoneMetadataFormats>());
    });

    test('should get metadata list for country calling code', () {
      expect(MetadataFinder.getMetadatasForCountryCode('33').length, equals(1));
      expect(MetadataFinder.getMetadatasForCountryCode('33')[0].isoCode,
          equals(IsoCode.FR));

      expect(MetadataFinder.getMetadatasForCountryCode('1').length,
          greaterThan(1));
      expect(MetadataFinder.getMetadatasForCountryCode('1')[0].isoCode,
          equals(IsoCode.US));
    });
  });
}
