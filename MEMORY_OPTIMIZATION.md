# Memory Optimization Guide

## Overview

The phone_numbers_parser plugin loads metadata for all 245 countries (~540KB) at startup. For apps that only work with specific countries, this can be wasteful. The warm-up and purge strategy allows you to reduce memory usage by up to 87%.

## How It Works

The plugin uses a three-phase approach:

### Phase 1: Warm-up (Load All)
- All 245 countries loaded in memory (~540KB)
- Parse phone numbers normally
- The loader tracks which countries you access

### Phase 2: Optimize (Purge Unused)
- Call `LazyMetadataLoader.instance.optimize()`
- Accessed countries are cached
- Original maps are cleared to free memory
- Memory usage drops to ~65KB (for typical 30 countries)

### Phase 3: Use (Optimized)
- Continue using the plugin normally
- Only warm-up countries remain available
- 87% memory savings achieved

## Usage Patterns

### Pattern 1: Known Countries (Recommended for Memory Savings)

Perfect for apps that only work with specific regions:

```dart
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/lazy_metadata_loader.dart';

void setupPhoneParser() {
  // Warm-up: Parse numbers from countries you'll use
  PhoneNumber.parse('+14155552671');  // United States
  PhoneNumber.parse('+33612345678');  // France
  PhoneNumber.parse('+441234567890'); // United Kingdom
  
  // Optimize: Purge unused countries
  LazyMetadataLoader.instance.optimize();
  
  // Result: Only US, FR, GB remain (~87% memory saved)
}

void usePhoneParser() {
  // These work (countries were in warm-up):
  final usPhone = PhoneNumber.parse('+13105551234');
  final frPhone = PhoneNumber.parse('+33698765432');
  
  // This fails (Japan not in warm-up):
  // PhoneNumber.parse('+81312345678'); // Throws error!
}
```

### Pattern 2: Dynamic Countries (No Optimization)

For apps that need to handle any country:

```dart
void usePhoneParser() {
  // Don't call optimize() - keep all countries
  
  // Parse any country at any time:
  PhoneNumber.parse('+14155552671');  // US - works
  PhoneNumber.parse('+81312345678');  // Japan - works
  PhoneNumber.parse('+5511987654321'); // Brazil - works
  
  // All 245 countries remain available
  // Memory: ~540KB (no optimization)
}
```

## Memory Savings

Typical savings with 30 countries accessed:

| Metric | Before optimize() | After optimize() | Savings |
|--------|------------------|------------------|---------|
| Countries | 245 | 30 | 87.8% |
| Metadata entries | 980 | 120 | 87.8% |
| Memory (approx) | ~540KB | ~65KB | ~475KB |

## App Lifecycle Behavior

### Background/Foreground
The optimization **persists** through normal background/foreground cycles:
```
User opens app → optimize() → backgrounds app → returns → still optimized ✓
```

### App Restart
The optimization **resets** when the app fully restarts:
```
User opens app → optimize() → force closes → reopens → all countries loaded ✓
```

This is beneficial because:
- Short backgrounds: Keep optimized state (good for memory)
- Long backgrounds: OS kills app, restarts with fresh data (good for flexibility)
- Natural lifecycle handles both use cases automatically

## Best Practices

### 1. Determine User's Countries
```dart
// Get from user preferences, locale, or business logic
List<IsoCode> getUserCountries() {
  final deviceLocale = PlatformDispatcher.instance.locale.countryCode;
  final userPreferences = getUserPreferences();
  return [deviceLocale, ...userPreferences];
}
```

### 2. Warm Up With Sample Numbers
```dart
void warmUpMetadata(List<IsoCode> countries) {
  for (final country in countries) {
    try {
      // Parse a sample number to load metadata
      final sample = getSampleNumberForCountry(country);
      PhoneNumber.parse(sample);
    } catch (e) {
      // Ignore errors during warm-up
    }
  }
}
```

### 3. Optimize After Warm-up
```dart
void initializePhoneParser() async {
  final countries = getUserCountries();
  warmUpMetadata(countries);
  
  // Optimize after warm-up
  LazyMetadataLoader.instance.optimize();
  
  print('Phone parser ready with ${countries.length} countries');
}
```

### 4. Monitor Cache Statistics
```dart
void checkMemoryUsage() {
  final stats = LazyMetadataLoader.instance.getCacheStats();
  
  print('Accessed countries: ${stats["accessed"]}');
  print('Cached entries: ${stats["total"]}');
  print('Optimized: ${stats["optimized"]}');
  
  final savings = ((245 - stats["accessed"]) / 245 * 100).toStringAsFixed(1);
  print('Memory savings: ~$savings%');
}
```

## When to Use Optimization

### ✅ Good Use Cases
- Apps serving specific regions (e.g., US-only, EU-only)
- Apps where users select their country at setup
- Apps with known country requirements
- Memory-constrained devices

### ❌ Not Recommended For
- Apps that parse international numbers from many countries
- Apps where users can enter any phone number
- Apps that need maximum flexibility
- When memory is not a concern

## Trade-offs

| Aspect | With optimize() | Without optimize() |
|--------|----------------|-------------------|
| Memory | ~65KB (87% savings) | ~540KB (full) |
| Flexibility | Limited to warm-up countries | All 245 countries |
| Setup | Requires warm-up phase | Ready immediately |
| Best for | Known countries | Dynamic countries |

## Example: Region-Specific App

```dart
class PhoneParserService {
  static Future<void> initialize({required List<String> regions}) async {
    // Map regions to sample numbers
    final samples = {
      'US': '+14155552671',
      'FR': '+33612345678',
      'GB': '+441234567890',
      'DE': '+491512345678',
    };
    
    // Warm up with user's regions
    for (final region in regions) {
      if (samples.containsKey(region)) {
        try {
          PhoneNumber.parse(samples[region]!);
        } catch (_) {}
      }
    }
    
    // Optimize to keep only these regions
    LazyMetadataLoader.instance.optimize();
    
    // Log results
    final stats = LazyMetadataLoader.instance.getCacheStats();
    print('✅ Phone parser initialized with ${stats["accessed"]} countries');
  }
}

// Usage in main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize with user's regions
  await PhoneParserService.initialize(regions: ['US', 'FR', 'GB']);
  
  runApp(MyApp());
}
```

## Testing Both Approaches

The demo file shows both patterns:

```bash
# Run the demo to see memory savings
dart run example/lib/lazy_loading_demo.dart

# Run tests (includes both optimized and non-optimized patterns)
dart test
```

## Monitoring in Production

```dart
class MemoryMonitor {
  static void logPhoneParserMemory() {
    final stats = LazyMetadataLoader.instance.getCacheStats();
    
    // Log to analytics
    Analytics.log('phone_parser_memory', {
      'accessed_countries': stats['accessed'],
      'cached_entries': stats['total'],
      'is_optimized': stats['optimized'],
      'memory_saved_percent': ((245 - stats['accessed']) / 245 * 100).round(),
    });
  }
}
```

## FAQ

**Q: Can I reload countries after optimize()?**  
A: No, once optimized, only warm-up countries remain. The app must be fully restarted to reload all countries.

**Q: What happens if I try to parse a new country after optimize()?**  
A: The parsing will fail with "IsoCode not found" error.

**Q: Does optimization persist through background/foreground?**  
A: Yes, it persists for the entire app session. Only a full app restart resets it.

**Q: When does the app naturally reset to full data?**  
A: When the OS kills the app (common after long background periods) or when the user force-closes and reopens the app.

**Q: Can I call optimize() multiple times?**  
A: Yes, but it only has effect the first time. Subsequent calls are ignored.

**Q: How do I know which countries to warm up?**  
A: Use user preferences, device locale, or business requirements to determine which countries your users need.
