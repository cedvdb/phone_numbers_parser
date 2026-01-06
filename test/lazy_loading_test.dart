import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/lazy_metadata_loader.dart';
import 'package:test/test.dart';

void main() {
  group('Warm-up and Purge Strategy', () {
    test('full lifecycle: warm-up, optimize, use', () {
      final loader = LazyMetadataLoader.instance;

      // Before warm-up
      final initial = loader.getCacheStats();
      final initialAccessed = initial['accessed'] as int;
      expect(initial['optimized'], equals(false));

      // Warm-up: parse some numbers
      PhoneNumber.parse('+14155552671'); // US
      PhoneNumber.parse('+33612345678'); // FR
      PhoneNumber.parse('+441234567890'); // GB

      // After warm-up: tracked but not cached
      final afterWarmup = loader.getCacheStats();
      expect(afterWarmup['accessed'], greaterThan(initialAccessed));
      expect(afterWarmup['optimized'], equals(false));

      // Optimize: purge unused countries
      loader.optimize();

      // After optimize: cached and optimized
      final afterOptimize = loader.getCacheStats();
      expect(afterOptimize['optimized'], equals(true));
      expect(afterOptimize['total'], greaterThan(0));
      expect(afterOptimize['total'], lessThan(200)); // Much less than 980

      // Should still work after optimization
      final phone = PhoneNumber.parse('+13105551234'); // US number
      expect(phone.isValid(type: PhoneNumberType.mobile), isTrue);

      // Formatting should work
      final formatted = phone.formatNsn();
      expect(formatted, isNotEmpty);
    });
  });

  group('Backward Compatibility (no optimization)', () {
    test('parsing still works without optimize', () {
      final numbers = [
        '+14155552671',
        '+33612345678',
        '+441234567890',
      ];

      for (var number in numbers) {
        expect(() => PhoneNumber.parse(number), returnsNormally);
      }
    });

    test('validation still works without optimize', () {
      final usPhone = PhoneNumber.parse('+14155552671');
      expect(usPhone.isValid(type: PhoneNumberType.mobile), isTrue);

      final frPhone = PhoneNumber.parse('+33612345678');
      expect(frPhone.isValid(type: PhoneNumberType.mobile), isTrue);
    });
  });
}
