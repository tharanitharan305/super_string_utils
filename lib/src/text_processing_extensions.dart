/// Text processing utilities.
extension TextProcessingExtensions on String {
  /// Reverses the order of words.
  String get reverseWords => trim().split(RegExp(r'\s+')).reversed.join(' ');
  
  /// Removes all whitespace.
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');
}
