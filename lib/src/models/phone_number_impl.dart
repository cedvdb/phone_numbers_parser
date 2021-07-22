import 'package:phone_number_metadata/src/models/phone_metadata.dart';

import 'phone_number.dart';

/// factory pattern with the parsers being the factories
class PhoneNumberImpl implements PhoneNumber {
  @override
  final String nsn;
  @override
  final String isoCode;

  /// metadata of the region the phone originates from
  @override
  final PhoneMetadata metadata;

  @override
  String get dialCode => metadata.dialCode;

  ///
  @override
  String get international => dialCode + nsn;

  const PhoneNumberImpl(this.isoCode, this.nsn, this.metadata);
}
