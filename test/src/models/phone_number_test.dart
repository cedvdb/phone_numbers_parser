import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  test('add/subtract', () async {
    var parser = PhoneParser();

    var start = parser.parseRaw('61383208100');

    start = start + 1;
    expect(start, equals(parser.parseRaw('61383208101')));

    start = start - 1;
    expect(start, equals(parser.parseRaw('61383208100')));
  });

  test('comparision', () async {
    var parser = PhoneParser();

    var zero = parser.parseRaw('61383208100');
    var one = parser.parseRaw('61383208101');

    expect(zero == zero, isTrue);
    expect(zero < one, isTrue);
    expect(zero <= one, isTrue);
    expect(zero > one, isFalse);
    expect(zero >= one, isFalse);
  });

  test('sequence', () async {
    var parser = PhoneParser();

    var zero = parser.parseRaw('61383208100');
    var one = parser.parseRaw('61383208101');
    var two = parser.parseRaw('61383208102');

    expect(zero.isAdjacentTo(one), isTrue);
    expect(zero.isSequentialTo(one), isTrue);

    expect(zero.isAdjacentTo(two), isFalse);
    expect(zero.isSequentialTo(two), isFalse);

    expect(one.isAdjacentTo(zero), isTrue);
    expect(one.isSequentialTo(zero), isFalse);

    expect(zero.isAdjacentTo(two), isFalse);
    expect(zero.isSequentialTo(two), isFalse);
  });
}
