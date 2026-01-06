import '../iso_codes/iso_code.dart';
import 'generated/country_code_to_iso_code.dart';
import 'generated/metadata_by_iso_code.dart';
import 'generated/metadata_formats_by_iso_code.dart';
import 'generated/metadata_lengths_by_iso_code.dart';
import 'generated/metadata_patterns_by_iso_code.dart';
import 'models/phone_metadata.dart';
import 'models/phone_metadata_formats.dart';
import 'models/phone_metadata_lengths.dart';
import 'models/phone_metadata_patterns.dart';

/// Lazy loader for phone metadata with warm-up and purge strategy.
///
/// This loader provides a way to reduce memory footprint by purging unused
/// country metadata after a warm-up period. Initially, all 245 countries
/// (~540KB) are loaded in memory. After calling [optimize()], only the
/// countries accessed during warm-up remain, reducing memory by up to 87%.
///
/// ## Usage Patterns
///
/// ### Pattern 1: Known Countries (Memory Optimization)
/// If your app only works with specific countries, use optimize():
/// ```dart
/// // Warm-up: Parse phone numbers from countries you'll use
/// PhoneNumber.parse('+14155552671'); // US
/// PhoneNumber.parse('+33612345678'); // FR
/// PhoneNumber.parse('+441234567890'); // GB
///
/// // Optimize: Purge unused countries (saves ~87% memory)
/// LazyMetadataLoader.instance.optimize();
///
/// // Continue using: Only US, FR, GB remain available
/// PhoneNumber.parse('+13105551234'); // Works! (US was in warm-up)
/// PhoneNumber.parse('+81312345678'); // Fails! (JP not in warm-up)
/// ```
///
/// ### Pattern 2: Dynamic Countries (Keep Flexibility)
/// If your app needs to parse any country at any time, don't call optimize():
/// ```dart
/// // Parse any country without warm-up or optimization
/// PhoneNumber.parse('+14155552671'); // Works
/// PhoneNumber.parse('+81312345678'); // Works
/// PhoneNumber.parse('+5511987654321'); // Works
/// // All 245 countries remain available
/// ```
///
/// ## Important Notes
///
/// - After [optimize()], only countries accessed during warm-up are available
/// - Attempting to parse new countries after optimization will fail
/// - The optimization persists for the app session (even through background/foreground)
/// - Full restart of the app reloads all countries
/// - Natural app lifecycle (OS killing backgrounded apps) automatically resets to full data
///
/// ## When to Call optimize()
///
/// Good use cases:
/// - Apps that only handle specific regions (e.g., US-only app)
/// - After initial user setup (selected their countries)
/// - When you know which countries will be used for the session
///
/// Don't call optimize() if:
/// - Users can parse any country at any time
/// - You need maximum flexibility
/// - Memory is not a concern
class LazyMetadataLoader {
  LazyMetadataLoader._();

  static final LazyMetadataLoader _instance = LazyMetadataLoader._();

  /// Get the singleton instance
  static LazyMetadataLoader get instance => _instance;

  // Track accessed countries during warm-up
  final Set<IsoCode> _accessedCodes = {};

  // Cache maps - populated after optimize()
  final Map<IsoCode, PhoneMetadata> _metadataCache = {};
  final Map<IsoCode, PhoneMetadataPatterns> _patternsCache = {};
  final Map<IsoCode, PhoneMetadataLengths> _lengthsCache = {};
  final Map<IsoCode, PhoneMetadataFormats> _formatsCache = {};

  bool _optimized = false;

  /// Get metadata for a specific ISO code
  PhoneMetadata? getMetadata(IsoCode isoCode) {
    _accessedCodes.add(isoCode);

    if (_optimized) {
      return _metadataCache[isoCode];
    }
    return metadataByIsoCode[isoCode];
  }

  /// Get pattern metadata for a specific ISO code
  PhoneMetadataPatterns? getPatterns(IsoCode isoCode) {
    _accessedCodes.add(isoCode);

    if (_optimized) {
      return _patternsCache[isoCode];
    }
    return metadataPatternsByIsoCode[isoCode];
  }

  /// Get length metadata for a specific ISO code
  PhoneMetadataLengths? getLengths(IsoCode isoCode) {
    _accessedCodes.add(isoCode);

    if (_optimized) {
      return _lengthsCache[isoCode];
    }
    return metadataLenghtsByIsoCode[isoCode];
  }

  /// Get format metadata for a specific ISO code
  /// Handles format references by following the reference chain
  PhoneMetadataFormats? getFormats(IsoCode isoCode) {
    _accessedCodes.add(isoCode);

    if (_optimized) {
      return _formatsCache[isoCode];
    }

    var metadata = metadataFormatsByIsoCode[isoCode];
    if (metadata is PhoneMetadataFormatReferenceDefinition) {
      metadata = metadataFormatsByIsoCode[metadata.referenceIsoCode];
    }

    if (metadata is PhoneMetadataFormatListDefinition) {
      return metadata.formats;
    }

    return null;
  }

  /// Get ISO codes for a country code (not cached as this is a small lookup)
  List<IsoCode> getIsoCodesFromCountryCode(String countryCode) {
    return countryCodeToIsoCode[countryCode] ?? [];
  }

  /// Optimize memory by purging unused countries.
  ///
  /// This method:
  /// 1. Copies all countries accessed during warm-up to an internal cache
  /// 2. Clears the original metadata maps to free memory
  /// 3. Keeps only the cached (used) countries in memory
  ///
  /// ## Memory Savings Example
  /// - Before: 245 countries × 4 metadata types = 980 entries (~540KB)
  /// - After warm-up with 30 countries: 30 × 4 = 120 entries (~65KB)
  /// - Memory saved: ~87%
  ///
  /// ## Critical Warning
  /// **After calling optimize(), new countries cannot be parsed!**
  ///
  /// Only countries accessed before optimize() remain available. Attempting
  /// to parse a new country will fail with "IsoCode not found" error.
  ///
  /// ## When It Resets
  /// The optimization persists for the entire app session, even when the app
  /// goes to background and returns. It only resets when:
  /// - User force-closes the app
  /// - OS kills the app (common after long background time)
  /// - App is restarted
  ///
  /// When the app restarts, all 245 countries are loaded again and you can
  /// call optimize() with a new set of countries.
  ///
  /// ## Best Practice
  /// ```dart
  /// // 1. Determine which countries your user needs
  /// final userCountries = getUserCountryPreferences(); // e.g., ['US', 'FR']
  ///
  /// // 2. Warm up by parsing sample numbers from those countries
  /// for (var country in userCountries) {
  ///   try {
  ///     PhoneNumber.parse(getSampleNumber(country));
  ///   } catch (_) {}
  /// }
  ///
  /// // 3. Optimize to keep only those countries
  /// LazyMetadataLoader.instance.optimize();
  ///
  /// // 4. Continue using with reduced memory footprint
  /// ```
  ///
  /// ## Idempotent
  /// Calling optimize() multiple times is safe - it only runs once.
  void optimize() {
    if (_optimized) return;

    // Copy accessed countries to cache
    for (var code in _accessedCodes) {
      final metadata = metadataByIsoCode[code];
      if (metadata != null) {
        _metadataCache[code] = metadata;
      }

      final patterns = metadataPatternsByIsoCode[code];
      if (patterns != null) {
        _patternsCache[code] = patterns;
      }

      final lengths = metadataLenghtsByIsoCode[code];
      if (lengths != null) {
        _lengthsCache[code] = lengths;
      }

      // Handle formats with references
      var formatDef = metadataFormatsByIsoCode[code];
      if (formatDef is PhoneMetadataFormatReferenceDefinition) {
        formatDef = metadataFormatsByIsoCode[formatDef.referenceIsoCode];
      }
      if (formatDef is PhoneMetadataFormatListDefinition) {
        _formatsCache[code] = formatDef.formats;
      }
    }

    // Clear original maps - this frees memory!
    metadataByIsoCode.clear();
    metadataPatternsByIsoCode.clear();
    metadataLenghtsByIsoCode.clear();
    metadataFormatsByIsoCode.clear();

    _optimized = true;
  }

  /// Clear all cached metadata (useful for testing)
  void clearCache() {
    _metadataCache.clear();
    _patternsCache.clear();
    _lengthsCache.clear();
    _formatsCache.clear();
    _accessedCodes.clear();
    _optimized = false;
  }

  /// Get cache statistics for monitoring
  Map<String, dynamic> getCacheStats() {
    return {
      'metadata': _metadataCache.length,
      'patterns': _patternsCache.length,
      'lengths': _lengthsCache.length,
      'formats': _formatsCache.length,
      'accessed': _accessedCodes.length,
      'optimized': _optimized,
      'total': _metadataCache.length +
          _patternsCache.length +
          _lengthsCache.length +
          _formatsCache.length,
    };
  }
}
