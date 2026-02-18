/// Internationalization checks.
extension InternationalExtensions on String {
  /// Checks if string contains only ASCII characters.
  bool get isAscii => RegExp(r'^[\x00-\x7F]*$').hasMatch(this);

  /// Checks if string contains characters outside Latin-1.
  bool get hasUnicode => runes.any((c) => c > 255);
}
