import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('MetadataFinder', () {
    test('should get metadata for iso code', () {
      expect(MetadataFinder.getMetadataForIsoCode('US').isoCode, equals('US'));
    });

    test('should get patterns metadata for iso code', () {
      expect(MetadataFinder.getMetadataPatternsForIsoCode('US'),
          isA<PhoneMetadataPatterns>());
    });

    test('should get lengths metadata for iso code', () {
      expect(MetadataFinder.getMetadataLengthForIsoCode('US'),
          isA<PhoneMetadataLengths>());
    });

    test('should get metadata list for dial code', () {
      expect(MetadataFinder.getMetadatasForDialCode('33').length, equals(1));
      expect(MetadataFinder.getMetadatasForDialCode('33')[0].isoCode,
          equals('FR'));

      expect(
          MetadataFinder.getMetadatasForDialCode('1').length, greaterThan(1));
      expect(
          MetadataFinder.getMetadatasForDialCode('1')[0].isoCode, equals('US'));
    });
  });
}
