/// Analytical extensions for text statistics.
extension AnalysisExtensions on String {
  /// Estimated reading time in minutes based on [wpm] (default 200).
  double readingTime({int wpm = 200}) {
    if (isEmpty) return 0;
    final words = trim().split(RegExp(r'\s+')).length;
    return words / wpm;
  }

  /// Returns a map of word frequencies.
  Map<String, int> get wordFrequency {
    if (isEmpty) return {};
    final map = <String, int>{};
    final words = toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').split(RegExp(r'\s+'));
    for (var word in words) {
      if (word.isNotEmpty) map[word] = (map[word] ?? 0) + 1;
    }
    return map;
  }
}
