import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/src/parsers/_national_number_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('_NationalPrefixParser', () {
    test('should remove nationalPrefix', () {
      final metadataFR = MetadataFinder.getMetadataForIsoCode(IsoCode.FR);
      final remove = NationalNumberParser.removeNationalPrefix;
      expect(remove('0488991144', metadataFR), equals('488991144'));
    });

    test('should remove remove nationalPrefix and transform', () {
      // in argentina 0343 15 555 1212 (local) is exactly the
      // number as +54 9 343 555 1212 (international)
      final metadataAR = MetadataFinder.getMetadataForIsoCode(IsoCode.AR);
      final tr =
          NationalNumberParser.transformLocalNsnToInternationalUsingPatterns;
      expect(tr('0343155551212', metadataAR), equals('93435551212'));
    });
  });
}
