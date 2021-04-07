// extension on regexp until they implement it https://github.com/dart-lang/sdk/issues/45586
extension MatchEntirely on RegExp {
  Match? matchEntirely(String string) {
    var pattern = this.pattern;
    if (!pattern.endsWith(r'$')) {
      pattern = pattern + r'$';
    }
    return RegExp(pattern).matchAsPrefix(string);
  }
}
