/// Extensions for parsing durations (e.g., "02:30:00").
extension DurationExtensions on String {
  /// Parses "HH:MM:SS" or "MM:SS" string to Duration.
  Duration? get toDurationOrNull {
    final parts = split(':');
    if (parts.length < 2 || parts.length > 3) return null;
    try {
      int h = 0, m = 0, s = 0;
      if (parts.length == 3) {
        h = int.parse(parts[0]);
        m = int.parse(parts[1]);
        s = int.parse(parts[2]);
      } else {
        m = int.parse(parts[0]);
        s = int.parse(parts[1]);
      }
      return Duration(hours: h, minutes: m, seconds: s);
    } catch (_) {
      return null;
    }
  }
}
