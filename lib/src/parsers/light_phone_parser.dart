import 'package:phone_number_parser/phone_number_parser.dart';
import 'package:phone_number_parser/src/parsers/_dial_code_parser.dart';
import 'package:phone_number_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_number_parser/src/parsers/_iso_code_parser.dart';
import 'package:phone_number_parser/src/parsers/_national_prefix_parser.dart';

abstract class LightPhoneParser {
  static void parseWithIsoCode(String isoCode, String phoneNumber) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadata = MetadataFinder.getLightMetadataForIsoCode(isoCode);
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    phoneNumber = DialCodeParser.removeDialCode(phoneNumber, metadata);
    phoneNumber =
        NationalPrefixParser.removeNationalPrefix(phoneNumber, metadata);
  }
}
