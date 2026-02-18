/// Advanced search capabilities.
extension SearchExtensions on String {
  /// Counts occurrences of [pattern].
  int countMatches(String pattern) {
    if (pattern.isEmpty) return 0;
    return pattern.allMatches(this).length;
  }

  /// Returns substring after the first occurrence of [delimiter].
  String substringAfter(String delimiter) {
    final index = indexOf(delimiter);
    if (index == -1) return '';
    return substring(index + delimiter.length);
  }

  /// Returns substring before the first occurrence of [delimiter].
  String substringBefore(String delimiter) {
    final index = indexOf(delimiter);
    if (index == -1) return this;
    return substring(0, index);
  }
}
