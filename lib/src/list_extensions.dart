/// Conversion to Lists.
extension ListExtensions on String {
  /// Splits by newline.
  List<String> get lines => split('\n');
  
  /// Splits CSV string to list.
  List<String> get csvToList => split(RegExp(r',\s*'));
  
  /// Chunks the string into a list of strings of length [size].
  List<String> chunk(int size) {
    return List.generate((length / size).ceil(), (i) {
      int start = i * size;
      int end = (start + size < length) ? start + size : length;
      return substring(start, end);
    });
  }
}
