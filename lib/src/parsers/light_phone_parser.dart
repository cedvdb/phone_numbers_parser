import 'package:phone_numbers_parser/phone_number_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number.dart';
import 'package:phone_numbers_parser/src/models/phone_number_impl.dart';
import 'package:phone_numbers_parser/src/models/phone_number_type.dart';
import 'package:phone_numbers_parser/src/parsers/_dial_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_international_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_iso_code_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_national_prefix_parser.dart';
import 'package:phone_numbers_parser/src/parsers/_validator.dart';

/// light parser, faster and lighter for tree shaking
///
/// The difference with the PhoneParser is that this does not use pattern information
/// to parse a phone number but it reduces the file size after tree shaking
/// (assuming the other parser was not imported).
///
/// If the objective is the most accuracy at the expense of file size and speed
/// then the other parser should be used.
/// If the objective is decent accuracy with lighter file size then this parser
/// can be used.
abstract class LightPhoneParser {
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
    final metadata = MetadataFinder.getLightMetadataForIsoCode(isoCode);
    phoneNumber =
        InternationalPrefixParser.removeInternationalPrefix(phoneNumber);
    phoneNumber = DialCodeParser.removeDialCode(phoneNumber, metadata.dialCode);
    final nsn =
        NationalPrefixParser.removeNationalPrefix(phoneNumber, metadata);
    return PhoneNumberImpl(nsn, metadata);
  }

  /// Validates a phone number using only the length information
  ///
  /// if a [type] is added, will validate against a specific type
  static bool validate(PhoneNumber phone, [PhoneNumberType? type]) {
    return Validator.validateWithLength(phone.nsn, phone.metadata, type);
  }
}
