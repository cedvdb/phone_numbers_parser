abstract class IsoCodeParser {
  /// normalize an iso code to be what the lib expects, mainly uppercases it
  static String normalizeIsoCode(String isoCode) {
    return isoCode.toUpperCase().trim();
  }
}
