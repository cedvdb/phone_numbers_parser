import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/phone_number_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/models/phone_number_exceptions.dart';
import 'package:phone_numbers_parser/src/models/phone_number_impl.dart';
import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/_dial_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/light_phone_parser.dart';

import '_iso_code_parser.dart';
import '_validator.dart';

/// Heavy parser
///
/// This parser is more accurate than the LightPhoneParser at the expense
/// of being more computationally intensive and resulting in a bigger
/// size when imported
///
/// It also furnishes more utilities that cannot be achieved with the light parser
abstract class PhoneParser {
  /// parses a [phoneNumber] given an [isoCode]
  ///
  /// The [phoneNumber] can be of the sort:
  ///  +33 478 88 88 88
  ///  0478 88 88 88
  ///  478 88 88 88
  ///
  /// throws a PhoneNumberException if the isoCode is invalid
  static PhoneNumber parseWithIsoCode(String isoCode, String phoneNumber) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadata = MetadataFinder.getExtendedMetadataForIsoCode(isoCode);
    phoneNumber = InternationalPrefixParser.removeInternationalPrefix(
        phoneNumber, metadata);
    phoneNumber = DialCodeParser.removeDialCode(phoneNumber, metadata);
    final nsn = NationalPrefixParser.transformLocalNsnToInternational(
        phoneNumber, metadata);
    return PhoneNumberImpl(nsn, metadata);
  }

  static PhoneNumber parseWithDialCode(String dialCode, String phoneNumber) {
    dialCode = DialCodeParser.normalizeDialCode(dialCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadatas = MetadataFinder.getExtendedMetadatasForDialCode(dialCode);
    final metadata = DialCodeParser.selectMetadataMatchForDialCode(
        dialCode, phoneNumber, metadatas);
    final nsn = NationalPrefixParser.transformLocalNsnToInternational(
        phoneNumber, metadata);
    return PhoneNumberImpl(nsn, metadata);
  }

  /// Validates a phone number using pattern matching
  ///
  /// if a [type] is added, will validate against a specific type
  static bool validate(PhoneNumber phone, [PhoneNumberType? type]) {
    final metadata = phone.metadata;
    if (phone.metadata is PhoneMetadataExtended) {
      return Validator.validateWithPattern(
        phone.nsn,
        metadata as PhoneMetadataExtended,
        type,
      );
    } else {
      return LightPhoneParser.validate(phone, type);
    }
  }
}
