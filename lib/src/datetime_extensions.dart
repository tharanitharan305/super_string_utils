/// Extensions for parsing dates.
extension DateTimeExtensions on String {
  /// Tries to parse the string as a DateTime.
  DateTime? get toDateTimeOrNull => DateTime.tryParse(this);

  /// Parses as DateTime or throws.
  DateTime get toDateTime => DateTime.parse(this);
  
  /// Checks if string is a valid ISO-8601 date.
  bool get isDate => DateTime.tryParse(this) != null;
}
