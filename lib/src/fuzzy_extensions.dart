import 'dart:math';

/// Advanced fuzzy matching.
extension FuzzyExtensions on String {
  /// Jaro-Winkler similarity score (0.0 to 1.0).
  double jaroWinkler(String other) {
    if (this == other) return 1.0;
    if (isEmpty || other.isEmpty) return 0.0;
    
    // Simplified Jaro implementation for illustration
    int matchDistance = (max(length, other.length) / 2).floor() - 1;
    final s1Matches = List<bool>.filled(length, false);
    final s2Matches = List<bool>.filled(other.length, false);
    int matches = 0;
    
    for (int i = 0; i < length; i++) {
      int start = max(0, i - matchDistance);
      int end = min(i + matchDistance + 1, other.length);
      for (int j = start; j < end; j++) {
        if (s2Matches[j]) continue;
        if (this[i] != other[j]) continue;
        s1Matches[i] = true;
        s2Matches[j] = true;
        matches++;
        break;
      }
    }
    if (matches == 0) return 0.0;
    
    int t = 0;
    int k = 0;
    for (int i = 0; i < length; i++) {
      if (!s1Matches[i]) continue;
      while (!s2Matches[k]) k++;
      if (this[i] != other[k]) t++;
      k++;
    }
    
    double m = matches.toDouble();
    return (m/length + m/other.length + (m - t/2)/m) / 3.0;
  }
}
