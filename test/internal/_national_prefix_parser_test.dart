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
  });
}
