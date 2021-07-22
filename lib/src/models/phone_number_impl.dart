import 'phone_number.dart';

/// factory pattern with the parsers being the factories
class PhoneNumberImpl implements PhoneNumber {
  @override
  final String nsn;
  @override
  final String isoCode;

  const PhoneNumberImpl(this.isoCode, this.nsn);
}
