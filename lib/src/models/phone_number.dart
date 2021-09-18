import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';

class PhoneNumber {
  /// National significant number in its internanational form
  final String nsn;

  /// country alpha2 code example: 'FR', 'US', ...
  final String isoCode;

  /// Country numerical code that precedes a phone number. Example 33 for france
  String get countryCode =>
      MetadataFinder.getMetadataForIsoCode(isoCode).countryCode;

  @Deprecated('use country code instead, dial code was semantically incorrect')
  String get dialCode => countryCode;

  /// international version of phone number
  String get international => '+' + countryCode + nsn;

  const PhoneNumber({
    required this.isoCode,
    required this.nsn,
  });

  @override
  String toString() => 'PhoneNumber(nsn: $nsn, isoCode: $isoCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneNumber && other.nsn == nsn && other.isoCode == isoCode;
  }

  @override
  int get hashCode => nsn.hashCode ^ isoCode.hashCode;
}
