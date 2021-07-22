import 'package:phone_number_parser/src/utils/_metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('MetadataFinder', () {
    test('should get light metadata for iso code', () {
      expect(MetadataFinder.getLightMetadataForIsoCode('US').isoCode,
          equals('US'));
    });

    test('should get extended metadata for iso code', () {
      expect(MetadataFinder.getExtendedMetadataForIsoCode('US').isoCode,
          equals('US'));
    });

    test('should get light metadata list for dial code', () {
      expect(
          MetadataFinder.getLightMetadatasForDialCode('33').length, equals(1));
      expect(MetadataFinder.getLightMetadatasForDialCode('33')[0].isoCode,
          equals('FR'));

      expect(MetadataFinder.getLightMetadatasForDialCode('1').length,
          greaterThan(1));
      expect(MetadataFinder.getLightMetadatasForDialCode('1')[0].isoCode,
          equals('US'));
    });

    test('should get light metadata list for dial code', () {
      expect(MetadataFinder.getExtendedMetadatasForDialCode('33').length,
          equals(1));
      expect(MetadataFinder.getExtendedMetadatasForDialCode('33')[0].isoCode,
          equals('FR'));

      expect(MetadataFinder.getExtendedMetadatasForDialCode('1').length,
          greaterThan(1));
      expect(MetadataFinder.getExtendedMetadatasForDialCode('1')[0].isoCode,
          equals('US'));
    });
  });
}
