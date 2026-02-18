/// Advanced replacements.
extension ReplacementExtensions on String {
  /// Replaces first occurrence ignoring case.
  String replaceFirstIgnoreCase(String from, String to) {
    if (isEmpty || from.isEmpty) return this;
    final index = toLowerCase().indexOf(from.toLowerCase());
    if (index == -1) return this;
    return replaceRange(index, index + from.length, to);
  }

  /// Replaces characters at specific index.
  String replaceAt(int index, String replacement) {
    if (index < 0 || index >= length) return this;
    return replaceRange(index, index + 1, replacement);
  }
}
