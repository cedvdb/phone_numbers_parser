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

  /// country code
  final String isoCode;

  /// metadata of the region the phone originates from
  final PhoneMetadata metadata;

  String get dialCode => metadata.dialCode;

  String get international => dialCode + nsn;

  const PhoneNumber._(this.isoCode, this.nsn, this.metadata);
}
