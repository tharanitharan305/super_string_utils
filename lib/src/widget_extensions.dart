import 'package:flutter/material.dart';
import 'builders/text_builder.dart';
import 'builders/text_list_builder.dart';
import 'builders/snackbar_builder.dart';

/// Widget generation extensions.
extension WidgetExtensions on String {

  /// Starts a fluent builder for a Text widget.
  TextBuilder get toTextBuilder => TextBuilder(this);

  /// Converts string directly to a Text widget (shortcut).
  Text toText({TextStyle? style, TextAlign? align}) {
    return Text(this, style: style, textAlign: align);
  }

  /// Starts a fluent builder for a SnackBar.
  SnackbarBuilder get toSnackbarBuilder => SnackbarBuilder(this);

  /// Converts string directly to a simple SnackBar (shortcut).
  SnackBar toSnackBar() => SnackBar(content: Text(this));
}

/// Extensions for lists of strings to build layouts.
extension StringListExtensions on List<String> {
  /// Starts a fluent builder for a Column of Text widgets.
  TextListBuilder toTextColumn() => TextListBuilder(this, axis: Axis.vertical);

  /// Starts a fluent builder for a Row of Text widgets.
  TextListBuilder toTextRow() => TextListBuilder(this, axis: Axis.horizontal);
}