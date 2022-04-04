class RegexpManager {
  static Match? matchEntirely(Pattern pattern, String string) {
    return RegExp('^(?:$pattern)\$').firstMatch(string);
  }

  static String applyTransformRules({
    required String appliedTo,
    required String pattern,
    required String? transformRule,
  }) {
    // match as prefix because we are only replacing the group and keeping
    // the end intact
    final match = RegExp(pattern).matchAsPrefix(appliedTo);

    if (match == null) {
      return appliedTo;
    }
    // if there is no group caught there is no need to transform
    // it is possible for a group to be null despite the group count being 1
    if (transformRule == null ||
        match.groupCount == 0 ||
        match.group(1) == null) {
      return appliedTo.substring(match.end);
    }

    var transformed = transformRule;
    bool shouldContinueLoop(int i) =>
        match.groupCount >= i &&
        match.group(i) != null &&
        transformed.contains('\$$i');
    for (var i = 1; shouldContinueLoop(i); i++) {
      transformed = transformed.replaceFirst('\$$i', match.group(i)!);
    }
    return transformed + appliedTo.substring(match.end);
  }
}
