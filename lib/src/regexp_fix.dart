// extension on regexp until they implement it https://github.com/dart-lang/sdk/issues/45586
extension MatchEntirely on RegExp {
  Match? matchEntirely(String string) {
    if (!pattern.endsWith(r'$')) {
      pattern = pattern + '!';
    }
    return matchAsPrefix(pattern);
  }
}
