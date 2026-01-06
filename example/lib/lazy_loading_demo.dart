import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/lazy_metadata_loader.dart';

/// Demonstrates the memory efficiency of lazy loading
///
/// This benchmark shows that using lazy loading, only metadata for
/// countries you actually use gets loaded into memory, rather than
/// loading all 245 countries upfront.
void main() {
  print('=== Phone Numbers Parser - Lazy Loading Benchmark ===\n');

  final loader = LazyMetadataLoader.instance;

  print('Initial state (no metadata loaded):');
  printStats(loader);
  print('');

  // Simulate typical usage: parse and validate a US phone number
  print('Parsing US phone number: +14155552671');
  final usPhone = PhoneNumber.parse('+14155552671');
  final isValidUS = usPhone.isValid(type: PhoneNumberType.mobile);
  print('Valid: $isValidUS');
  printStats(loader);
  print('');

  // Parse another US number (should use cache)
  print('Parsing another US number: +13105551234');
  final usPhone2 = PhoneNumber.parse('+13105551234');
  final isValidUS2 = usPhone2.isValid(type: PhoneNumberType.mobile);
  print('Valid: $isValidUS2');
  printStats(loader);
  print('');

  // Parse a French number
  print('Parsing French number: +33612345678');
  final frPhone = PhoneNumber.parse('+33612345678');
  final isValidFR = frPhone.isValid(type: PhoneNumberType.mobile);
  print('Valid: $isValidFR');
  printStats(loader);
  print('');

  // Parse a UK number
  print('Parsing UK number: +447911123456');
  final ukPhone = PhoneNumber.parse('+447911123456');
  final isValidUK = ukPhone.isValid(type: PhoneNumberType.mobile);
  print('Valid: $isValidUK');
  printStats(loader);
  print('');

  print('=== Summary ===');
  print('With traditional approach: ~980 metadata entries loaded upfront');
  print('  (245 countries × 4 metadata types)');
  print('');
  final stats = loader.getCacheStats();
  print('With lazy loading: ${stats["total"]} entries loaded on-demand');
  final savings =
      ((980 - (stats['total'] ?? 0)) / 980 * 100).toStringAsFixed(1);
  print('Memory savings: ~$savings%');
  print('');
  print('Lazy loading only loads metadata for countries you actually use!');
}

void printStats(LazyMetadataLoader loader) {
  final stats = loader.getCacheStats();
  print('  Cache: ${stats["total"]} entries total');
  print(
      '    └─ Metadata: ${stats["metadata"]} | Patterns: ${stats["patterns"]} | '
      'Lengths: ${stats["lengths"]} | Formats: ${stats["formats"]}');
}
