/// Match a pattern against a String. A match happens
/// when both match entirely. That is 'abc' will match
/// with only 'abc'
extension MatchEntirely on Pattern {
  Match? matchEntirely(String string) {
    return RegExp('^(?:$this)\$').firstMatch(string);
  }
}
