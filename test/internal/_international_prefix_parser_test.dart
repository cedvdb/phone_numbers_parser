import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';
import 'package:test/test.dart';

void main() {
  group('_InternationalPrefixParser', () {
    final fix = InternationalPrefixParser.removeInternationalPrefix;

    test('should remove + prefix in all cases', () {
      expect(fix('+654'), '654');
      expect(fix('+654', MetadataFinder.getMetadataForIsoCode('US')), '654');
    });

    test('should remove remove 00 and 011 prefixes, if no metadata provided',
        () {
      expect(fix('00654'), '654');
      expect(fix('011654'), '654');
      expect(fix('00654', MetadataFinder.getMetadataForIsoCode('US')), '00654');
    });

    test('should remove prefix from metadata', () {
      expect(fix('011654', MetadataFinder.getMetadataForIsoCode('US')), '654');
      expect(
          fix('0033654', MetadataFinder.getMetadataForIsoCode('FR')), '33654');
    });
  });
}
