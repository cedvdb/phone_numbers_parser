import 'package:phone_number_metadata/phone_number_metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/models/phone_number_impl.dart';
import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/_dial_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/light_phone_parser.dart';
import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';

import '_iso_code_parser.dart';
import '_text_parser.dart';
import '_validator.dart';

/// {@template phoneNumber}
/// The [phoneNumber] can be of the sort:
///  +33 478 88 88 88,
///  0478 88 88 88,
///  478 88 88 88
/// {@endtemplate}

/// Heavy parser
///
/// This parser is more accurate than the LightPhoneParser at the expense
/// of being more computationally intensive and resulting in a bigger
/// size when imported
///
/// It also furnishes more utilities that cannot be achieved with the light parser
class PhoneParser extends LightPhoneParser {
  /// parses a [phoneNumber] given an [isoCode]
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the isoCode is invalid
  @override
  PhoneNumber parseWithIsoCode(String isoCode, String phoneNumber) {
    isoCode = IsoCodeParser.normalizeIsoCode(isoCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    final metadata = MetadataFinder.getExtendedMetadataForIsoCode(isoCode);
    phoneNumber = InternationalPrefixParser.removeInternationalPrefix(
        phoneNumber, metadata);
    phoneNumber = DialCodeParser.removeDialCode(phoneNumber, metadata.dialCode);
    final nsn = NationalPrefixParser.transformLocalNsnToInternational(
        phoneNumber, metadata);
    return PhoneNumberImpl(nsn, metadata);
  }

  /// parses a [phoneNumber] given a [dialCode]
  ///
  /// Use parseWithIsoCode when possible at multiple countries
  /// use the same dial code.
  ///
  /// {@macro phoneNumber}
  ///
  /// throws a PhoneNumberException if the dial code is invalid
  PhoneNumber parseWithDialCode(String dialCode, String phoneNumber) {
    dialCode = DialCodeParser.normalizeDialCode(dialCode);
    phoneNumber = TextParser.normalize(phoneNumber);
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    phoneNumber = DialCodeParser.removeDialCode(phoneNumber, dialCode);
    final metadatas = MetadataFinder.getExtendedMetadatasForDialCode(dialCode);
    final metadata = DialCodeParser.selectMetadataMatchForDialCode(
        dialCode, phoneNumber, metadatas);
    final nsn = NationalPrefixParser.transformLocalNsnToInternational(
        phoneNumber, metadata);
    return PhoneNumberImpl(nsn, metadata);
  }

  /// parses a [phoneNumber] given a [dialCode]
  ///
  /// Use parseWithIsoCode when possible at multiple countries
  /// use the same dial code.
  ///
  /// This assumes the phone number starts with the dial code
  ///
  /// throws a PhoneNumberException if the dial code is invalid
  PhoneNumber parseRaw(String phoneNumber) {
    phoneNumber = TextParser.normalize(phoneNumber);
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    final dialCode = DialCodeParser.extractDialCode(phoneNumber);
    return parseWithDialCode(dialCode, phoneNumber);
  }

  /// Validates a phone number using pattern matching
  ///
  /// if a [type] is added, will validate against a specific type
  @override
  bool validate(PhoneNumber phone, [PhoneNumberType? type]) {
    final metadata = phone.metadata;
    if (phone.metadata is PhoneMetadataExtended) {
      return Validator.validateWithPattern(
        phone.nsn,
        metadata as PhoneMetadataExtended,
        type,
      );
    } else {
      return super.validate(phone, type);
    }
  }

  @override
  PhoneNumber copyWithIsoCode(PhoneNumber phoneNumber, String isoCode) {
    return parseWithIsoCode(isoCode, phoneNumber.nsn);
  }
}
