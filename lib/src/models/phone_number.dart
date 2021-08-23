import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';

class PhoneNumber {
  /// National significant number in its internanational form
  final String nsn;

  /// country alpha2 code example: 'FR', 'US', ...
  final String isoCode;

  /// territory numerical code that precedes a phone number. Example 33 for france
  String get dialCode => MetadataFinder.getMetadataForIsoCode(isoCode).dialCode;

  /// international version of phone number
  String get international => '+' + dialCode + nsn;

  const PhoneNumber({
    required this.isoCode,
    required this.nsn,
  });
}
