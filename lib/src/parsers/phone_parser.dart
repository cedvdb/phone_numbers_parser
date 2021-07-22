import 'package:phone_number_parser/phone_number_parser.dart';
import 'package:phone_number_parser/src/parsers/_dial_code_parser.dart';
import 'package:phone_number_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_number_parser/src/parsers/_national_prefix_parser.dart';

import '_iso_code_parser.dart';

abstract class PhoneParser {
  static void parseWithIsoCode(String isoCode, String phoneNumber) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadata = MetadataFinder.getExtendedMetadataForIsoCode(isoCode);
    phoneNumber = InternationalPrefixParser.removeInternationalPrefix(
        phoneNumber, metadata);
    phoneNumber = DialCodeParser.removeDialCode(phoneNumber, metadata);
    phoneNumber = NationalPrefixParser.transformLocalNsnToInternational(
        phoneNumber, metadata);
  }

  static parseWithDialCode(String dialCode, String nationalNumber) {
    dialCode = DialCodeParser.normalizeDialCode(dialCode);
    nationalNumber = TextParser.normalize(nationalNumber);
    final metadatas = MetadataFinder.getExtendedMetadatasForDialCode(dialCode);
    final metadata = DialCodeParser.selectMetadataMatchForDialCode(
        dialCode, nationalNumber, metadatas);
    nationalNumber = NationalPrefixParser.transformLocalNsnToInternational(
        nationalNumber, metadata);
  }
}
