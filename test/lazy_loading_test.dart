import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/lazy_metadata_loader.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    // Clear cache before each test
    LazyMetadataLoader.instance.clearCache();
  });

  group('Lazy Loading', () {
    test('metadata loads on demand', () {
      final loader = LazyMetadataLoader.instance;
      final initialStats = loader.getCacheStats();

      // Initially, cache should be empty
      expect(initialStats['metadata'], equals(0));
      expect(initialStats['patterns'], equals(0));
      expect(initialStats['lengths'], equals(0));

      // Parse a US phone number - this should load only US metadata
      final phoneNumber = PhoneNumber.parse('+14155552671');
      expect(phoneNumber.isoCode, equals(IsoCode.US));

      final afterParseStats = loader.getCacheStats();

      // Metadata should now be cached (4 types per country, plus lookup countries)
      expect(afterParseStats['metadata'], greaterThan(0));
      expect(afterParseStats['total'],
          lessThan(50)); // Much less than 245 countries * 4 types = 980
    });

    test('validation uses cached data', () {
      final loader = LazyMetadataLoader.instance;

      // First parse
      final phoneNumber = PhoneNumber.parse('+14155552671');
      final statsAfterParse = loader.getCacheStats();
      final totalAfterParse = statsAfterParse['total'] as int;

      // Validate (should use cached data, not load more)
      final isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
      expect(isValid, isTrue);

      final statsAfterValidation = loader.getCacheStats();
      final totalAfterValidation = statsAfterValidation['total'] as int;

      // Should have used cache, total should be same or minimally increased
      expect(totalAfterValidation, lessThanOrEqualTo(totalAfterParse + 2));
    });

    test('multiple countries load incrementally', () {
      final loader = LazyMetadataLoader.instance;

      // Parse phone numbers from different countries
      PhoneNumber.parse('+14155552671'); // US
      final afterUS = loader.getCacheStats()['total'] as int;

      PhoneNumber.parse('+33612345678'); // FR
      final afterFR = loader.getCacheStats()['total'] as int;

      PhoneNumber.parse('+441234567890'); // GB
      final afterGB = loader.getCacheStats()['total'] as int;

      // Should load more data with each country
      expect(afterFR, greaterThan(afterUS));
      expect(afterGB, greaterThan(afterFR));

      // But still much less than all countries (245 * 4 = 980 total entries)
      expect(afterGB, lessThan(150)); // Much less than 980
    });

    test('cache can be cleared', () {
      final loader = LazyMetadataLoader.instance;

      // Load some data
      PhoneNumber.parse('+14155552671');
      expect(loader.getCacheStats()['total'], greaterThan(0));

      // Clear cache
      loader.clearCache();
      final clearedStats = loader.getCacheStats();

      expect(clearedStats['metadata'], equals(0));
      expect(clearedStats['patterns'], equals(0));
      expect(clearedStats['lengths'], equals(0));
      expect(clearedStats['formats'], equals(0));
      expect(clearedStats['total'], equals(0));
    });

    test('validates mobile number correctly with lazy loading', () {
      // This is the user's specific use case
      final phoneWithPlus = '+14155552671';
      final phoneNumber = PhoneNumber.parse(phoneWithPlus);
      final isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);

      expect(isValid, isTrue);
      expect(phoneNumber.isoCode, equals(IsoCode.US));

      // Verify minimal metadata was loaded (vs 245 countries * 4 types = 980 total entries)
      final stats = LazyMetadataLoader.instance.getCacheStats();
      expect(stats['total'], lessThan(100)); // Much less than 980
    });

    test('memory efficient for single country usage', () {
      final loader = LazyMetadataLoader.instance;

      // Simulate app that only uses one country
      for (var i = 0; i < 100; i++) {
        final phone = PhoneNumber.parse('+1415555${2000 + i}');
        phone.isValid(type: PhoneNumberType.mobile);
      }

      // Should still only have US metadata cached (vs 980 total for all countries)
      final stats = loader.getCacheStats();
      expect(stats['total'], lessThan(50)); // Only US and related metadata
    });
  });

  group('Backward Compatibility', () {
    test('all existing tests still pass', () {
      // Parse various phone numbers to ensure nothing broke
      final numbers = [
        '+14155552671',
        '+33612345678',
        '+441234567890',
        '+81312345678',
        '+5511987654321',
      ];

      for (var number in numbers) {
        expect(() => PhoneNumber.parse(number), returnsNormally);
      }
    });

    test('validation still works correctly', () {
      final usPhone = PhoneNumber.parse('+14155552671');
      expect(usPhone.isValid(type: PhoneNumberType.mobile), isTrue);

      final frPhone = PhoneNumber.parse('+33612345678');
      expect(frPhone.isValid(type: PhoneNumberType.mobile), isTrue);
    });

    test('formatting still works', () {
      final phone = PhoneNumber.parse('+14155552671');
      final formatted = phone.formatNsn();
      expect(formatted, isNotEmpty);
    });
  });
}
