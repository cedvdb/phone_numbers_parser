import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumber', () {
    test('two phones numbers with the same values should be equal', () {
      expect(PhoneNumber(isoCode: '33', nsn: '479999999'),
          equals(PhoneNumber(isoCode: '33', nsn: '479999999')));
    });
  });
}
