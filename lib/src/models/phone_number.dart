// class PhoneNumber {
//   /// National significant number
//   final String nsn;

//   /// country code
//   final String isoCode;

//   /// The national number given as input,
//   /// it may or may not equal nsn depending on whether or
//   /// not transformation was applied
//   /// marked as private atm because it could lead to confusion.
//   final String _nationalInput;

//   String get dialCode => countriesDialcode[isoCode]!;
//   String get international => '+' + dialCode + nsn;

//   PhoneNumber(this.isoCode, String national) : _nationalInput = national;
// }

import 'package:phone_number_metadata/phone_number_metadata.dart';

abstract class PhoneNumber {
  /// National significant number in its internanational form
  final String nsn;

  /// metadata of the region the phone originates from
  final PhoneMetadata metadata;

  String get dialCode => throw 'unimplemented';

  /// country alpha2 code example: 'FR', 'US', ...
  String get isoCode => throw 'unimplemented';

  /// international version of phone number
  String get international => throw 'unimplemented';

  const PhoneNumber._(this.nsn, this.metadata);
}
