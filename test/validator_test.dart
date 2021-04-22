import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/validator.dart';
import 'package:test/test.dart';

void main() {
  group('Validator', () {
    test('should validate national number', () {
      final country = Country.fromIsoCode('be');
      final desc = country.phoneDescription;
      final validate = Validator.isValidNationalNumber;
      expect(validate('71223344', desc), equals(true));
      expect(validate('475454545', desc), equals(true));
      expect(validate('71223344999', desc), equals(false));
      expect(validate('475454545999', desc), equals(false));
      expect(validate('7122334', desc), equals(false));
      expect(validate('4754545', desc), equals(false));
    });

    test('should validate national number by type', () {
      final country = Country.fromIsoCode('be');
      final desc = country.phoneDescription;
      final validate = Validator.isValidForType;
      final mobile = PhoneNumberType.mobile;
      final fix = PhoneNumberType.fixedLine;
      expect(validate(fix, '71223344', desc), equals(true));
      expect(validate(fix, '475454545', desc), equals(false));
      expect(validate(fix, '71223344999', desc), equals(false));
      expect(validate(mobile, '475454545', desc), equals(true));
      expect(validate(mobile, '4754545454', desc), equals(false));
      expect(validate(mobile, '47545454', desc), equals(false));
      expect(validate(mobile, '775454545', desc), equals(false));
    });
  });
}
