import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/models/phone_number_range.dart';
import 'package:test/test.dart';

void main() {
  test('count', () async {
    var zero = PhoneNumber.fromRaw('61383208100');
    var one = PhoneNumber.fromRaw('61383208101');
    var two = PhoneNumber.fromRaw('61383208102');
    var ninenine = PhoneNumber.fromRaw('61383208199');

    expect(PhoneNumberRange(zero, one).count, equals(2));
    expect(PhoneNumberRange(zero, two).count, equals(3));
    expect(PhoneNumberRange(two, zero).count, equals(3));

    expect(PhoneNumberRange(zero, ninenine).count, equals(100));
  });

  test('range', () async {
    var zero = PhoneNumber.fromRaw('61383208100');
    var one = PhoneNumber.fromRaw('61383208101');
    var two = PhoneNumber.fromRaw('61383208102');
    var ninenine = PhoneNumber.fromRaw('61383208199');

    expect(PhoneNumberRange(zero, one).expandRange().length, equals(2));
    expect(PhoneNumberRange(zero, two).expandRange().length, equals(3));
    expect(PhoneNumberRange(zero, ninenine).expandRange().length, equals(100));

    expect(PhoneNumberRange(zero, one).expandRange(),
        containsAllInOrder([zero, one]));

    expect(PhoneNumberRange(zero, ninenine).expandRange(),
        containsAllInOrder([zero, one, two, ninenine]));
  });
}
