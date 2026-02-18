/// Structural checks.
extension StructuralExtensions on String {
  /// Returns null if the string is empty.
  String? get nullIfEmpty => isEmpty ? null : this;
  
  /// Returns null if the string is blank.
  String? get nullIfBlank => trim().isEmpty ? null : this;
}
