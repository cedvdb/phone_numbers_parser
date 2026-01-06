import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/lazy_metadata_loader.dart';

/// Demonstrates the memory efficiency of warm-up and purge strategy
///
/// Strategy:
/// 1. Initially all 245 countries loaded (~540KB)
/// 2. During warm-up, track which countries are used
/// 3. Call optimize() to purge unused countries
/// 4. Memory footprint reduced to only used countries
void main() {
  print('=== Phone Numbers Parser - Warm-up & Purge Strategy ===\n');

  final loader = LazyMetadataLoader.instance;

  print('Phase 1: WARM-UP (all metadata loaded)');
  print('  - All 245 countries available: ~540KB in memory');
  printStats(loader);
  print('');

  // Simulate typical usage: parse and validate phone numbers
  print('Parsing US phone number: +14155552671');
  final usPhone = PhoneNumber.parse('+14155552671');
  print('Valid: ${usPhone.isValid(type: PhoneNumberType.mobile)}');

  print('Parsing French phone number: +33612345678');
  final frPhone = PhoneNumber.parse('+33612345678');
  print('Valid: ${frPhone.isValid(type: PhoneNumberType.mobile)}');

  print('Parsing UK phone number: +447911123456');
  final ukPhone = PhoneNumber.parse('+447911123456');
  print('Valid: ${ukPhone.isValid(type: PhoneNumberType.mobile)}');

  print('\nAfter warm-up:');
  printStats(loader);
  print('');

  // OPTIMIZE: Purge unused countries!
  print('Phase 2: OPTIMIZATION');
  print('  - Calling optimize()...');
  loader.optimize();
  print('  - Unused countries purged!');
  print('  - Original maps cleared');
  printStats(loader);
  print('');

  // Verify it still works
  print('Phase 3: VERIFICATION');
  print('Parsing another US number: +13105551234');
  final usPhone2 = PhoneNumber.parse('+13105551234');
  print('Valid: ${usPhone2.isValid(type: PhoneNumberType.mobile)}');
  printStats(loader);
  print('');

  print('=== Summary ===');
  print('Before optimize(): ~980 metadata entries (540KB)');
  print('  - All 245 countries × 4 metadata types');
  print('');
  final stats = loader.getCacheStats();
  print('After optimize(): ${stats["total"]} entries');
  print('  - Only ${stats["accessed"]} countries accessed');
  print('  - Unused countries freed from memory');
  print('');
  final used = stats['accessed'] as int;
  final savings = ((245 - used) / 245 * 100).toStringAsFixed(1);
  print('Memory savings: ~$savings% of countries purged');
  print('');
  print('Warm-up & purge strategy successfully reduces memory');
}

void printStats(LazyMetadataLoader loader) {
  final stats = loader.getCacheStats();
  print('  Accessed countries: ${stats["accessed"]}');
  print('  Cached entries: ${stats["total"]}');
  print('  Optimized: ${stats["optimized"]}');
}
