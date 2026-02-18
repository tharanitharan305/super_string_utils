/// Advanced numeric parsing.
extension NumericExtensions on String {
  /// Flexible boolean parsing (true, 1, yes, on).
  bool get toBool {
    final lower = toLowerCase().trim();
    return lower == 'true' || lower == '1' || lower == 'yes' || lower == 'on';
  }

  /// Parse double or return null.
  double? get toDoubleOrNull => double.tryParse(this);

  /// Parse int or return null.
  int? get toIntOrNull => int.tryParse(this);
  
  /// Checks if string is a valid binary number.
  bool get isBinary => RegExp(r'^[01]+$').hasMatch(this);
  
  /// Checks if string is a valid Hexadecimal.
  bool get isHex => RegExp(r'^[0-9A-Fa-f]+$').hasMatch(this);
}
