import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('_InternationalPrefixParser', () {
    final fix = InternationalPrefixParser.extractExitCode;

    test('should remove + prefix in all cases', () {
      expect(fix('+654'), ('+', '654'));
      final metadata = MetadataFinder.findMetadataForIsoCode(IsoCode.US);
      expect(fix('+654', destinationCountryMetadata: metadata), ('+', '654'));
      expect(fix('+654', callerCountryMetadata: metadata), ('+', '654'));
    });

    test('should remove international prefix from caller', () {
      final metadataUS = MetadataFinder.findMetadataForIsoCode(IsoCode.US);
      final metadataFR = MetadataFinder.findMetadataForIsoCode(IsoCode.FR);
      expect(fix('01199', callerCountryMetadata: metadataUS), ('011', '99'));
      expect(fix('0099', callerCountryMetadata: metadataFR), ('00', '99'));
    });

    test('should remove remove 00 and 011 prefixes, if no metadata provided',
        () {
      expect(fix('00654'), ('00', '654'));
      expect(fix('011654'), ('011', '654'));
    });

    test('should not remove international prefix if country code not following',
        () {
      final frMetadata = MetadataFinder.findMetadataForIsoCode(IsoCode.FR);
      final beMetadata = MetadataFinder.findMetadataForIsoCode(IsoCode.BE);

      expect(fix('0032', destinationCountryMetadata: beMetadata), ('00', '32'));
      expect(fix('0033', destinationCountryMetadata: beMetadata), ('', '0033'));
      expect(
          fix('00777', destinationCountryMetadata: frMetadata), ('', '00777'));
    });
  });
}
