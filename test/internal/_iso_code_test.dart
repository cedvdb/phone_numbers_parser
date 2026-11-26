import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('IsoCode', () {
    test('should serialize and deserialize', () {
      expect(IsoCode.fromJson(IsoCode.FR.toJson()), equals(IsoCode.FR));
      expect(IsoCode.fromJson('BE'), equals(IsoCode.BE));
    });

    test('should throw a PhoneNumberException for an unknown iso code', () {
      // a raw String used to be thrown, which cannot be caught as an Exception
      for (final isoCode in ['XX', '']) {
        expect(
          () => IsoCode.fromJson(isoCode),
          throwsA(
            isA<PhoneNumberException>()
                .having((e) => e.code, 'code', Code.invalidIsoCode),
          ),
        );
      }
    });
  });
}
