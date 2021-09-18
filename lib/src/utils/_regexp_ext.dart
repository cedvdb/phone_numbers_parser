// extension on regexp until they implement it https://github.com/dart-lang/sdk/issues/45586
extension MatchEntirely on RegExp {
  Match? matchEntirely(String string) {
    return RegExp('^(?:$pattern)\$').firstMatch(string);
  }
}
