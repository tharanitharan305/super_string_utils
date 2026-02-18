import 'dart:convert';

/// Conversion to Maps.
extension MapExtensions on String {
  /// Tries to parse JSON string to Map.
  Map<String, dynamic>? get jsonToMap {
    try {
      final decoded = jsonDecode(this);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  /// Parses URL query string to Map.
  Map<String, String> get queryToMap {
    if (isEmpty) return {};
    return Uri.splitQueryString(this);
  }
}
