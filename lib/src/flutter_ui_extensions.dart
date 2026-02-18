import 'package:flutter/material.dart';

/// Flutter-specific extensions.
extension FlutterUiExtensions on String {
  /// Parses a Hex color string (e.g. "#FF0000" or "FF0000") to a [Color].
  /// Returns [Colors.black] if invalid.
  Color get toColor {
    var hex = replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    if (hex.length == 8) {
      return Color(int.tryParse('0x$hex') ?? 0xFF000000);
    }
    return Colors.black;
  }
}
