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

/// Lazy loader for phone metadata that loads country data on-demand
/// and caches it for subsequent access. This reduces initial memory
/// footprint by only loading metadata for countries actually used.
class LazyMetadataLoader {
  LazyMetadataLoader._();

  static final LazyMetadataLoader _instance = LazyMetadataLoader._();

  /// Get the singleton instance
  static LazyMetadataLoader get instance => _instance;

  // Cache maps - start empty and populate on demand
  final Map<IsoCode, PhoneMetadata> _metadataCache = {};
  final Map<IsoCode, PhoneMetadataPatterns> _patternsCache = {};
  final Map<IsoCode, PhoneMetadataLengths> _lengthsCache = {};
  final Map<IsoCode, PhoneMetadataFormats> _formatsCache = {};

  /// Get metadata for a specific ISO code, loading it if not cached
  PhoneMetadata? getMetadata(IsoCode isoCode) {
    if (_metadataCache.containsKey(isoCode)) {
      return _metadataCache[isoCode];
    }

    final metadata = metadataByIsoCode[isoCode];
    if (metadata != null) {
      _metadataCache[isoCode] = metadata;
    }
    return metadata;
  }

  /// Get pattern metadata for a specific ISO code, loading it if not cached
  PhoneMetadataPatterns? getPatterns(IsoCode isoCode) {
    if (_patternsCache.containsKey(isoCode)) {
      return _patternsCache[isoCode];
    }

    final patterns = metadataPatternsByIsoCode[isoCode];
    if (patterns != null) {
      _patternsCache[isoCode] = patterns;
    }
    return patterns;
  }

  /// Get length metadata for a specific ISO code, loading it if not cached
  PhoneMetadataLengths? getLengths(IsoCode isoCode) {
    if (_lengthsCache.containsKey(isoCode)) {
      return _lengthsCache[isoCode];
    }

    final lengths = metadataLenghtsByIsoCode[isoCode];
    if (lengths != null) {
      _lengthsCache[isoCode] = lengths;
    }
    return lengths;
  }

  /// Get format metadata for a specific ISO code, loading it if not cached
  /// Handles format references by following the reference chain
  PhoneMetadataFormats? getFormats(IsoCode isoCode) {
    if (_formatsCache.containsKey(isoCode)) {
      return _formatsCache[isoCode];
    }

    var metadata = metadataFormatsByIsoCode[isoCode];
    if (metadata is PhoneMetadataFormatReferenceDefinition) {
      metadata = metadataFormatsByIsoCode[metadata.referenceIsoCode];
    }

    if (metadata is PhoneMetadataFormatListDefinition) {
      _formatsCache[isoCode] = metadata.formats;
      return metadata.formats;
    }

    return null;
  }

  /// Get ISO codes for a country code (not cached as this is a small lookup)
  List<IsoCode> getIsoCodesFromCountryCode(String countryCode) {
    return countryCodeToIsoCode[countryCode] ?? [];
  }

  /// Clear all cached metadata (useful for testing or memory management)
  void clearCache() {
    _metadataCache.clear();
    _patternsCache.clear();
    _lengthsCache.clear();
    _formatsCache.clear();
  }

  /// Get cache statistics for monitoring
  Map<String, int> getCacheStats() {
    return {
      'metadata': _metadataCache.length,
      'patterns': _patternsCache.length,
      'lengths': _lengthsCache.length,
      'formats': _formatsCache.length,
      'total': _metadataCache.length +
          _patternsCache.length +
          _lengthsCache.length +
          _formatsCache.length,
    };
  }
}
