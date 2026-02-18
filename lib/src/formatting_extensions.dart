/// Extensions for text indentation and alignment.
extension FormattingExtensions on String {
  /// Indents each line by [spaces].
  String indent(int spaces) {
    final p = ' ' * spaces;
    return split('\n').map((line) => '$p$line').join('\n');
  }

  /// Removes common leading whitespace.
  String get unindent => replaceAll(RegExp(r'^\s+', multiLine: true), '');
}
