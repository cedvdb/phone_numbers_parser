import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/validator.dart';
import 'package:test/test.dart';

void main() {
  group('Validator', () {
    test('should validate correctly', () {
      final country = Country.fromIsoCode('be');
      Validator.isValidNationalNumber('', country.phoneDescription);
    });
  });
}
