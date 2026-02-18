import 'package:flutter/material.dart';

/// A fluent builder for a single Text widget.
@immutable
class TextBuilder {
  final String _text;
  final TextStyle? _style;
  final TextAlign? _textAlign;
  final TextOverflow? _overflow;
  final int? _maxLines;

  // Layout properties
  final bool _isExpanded;
  final int? _flex;
  final EdgeInsetsGeometry? _padding;
  final BoxDecoration? _containerDecoration;
  final Color? _containerColor;
  final EdgeInsetsGeometry? _containerMargin;
  final Widget Function(Widget child)? _customWrapper;

  const TextBuilder(
      this._text, {
        TextStyle? style,
        TextAlign? textAlign,
        TextOverflow? overflow,
        int? maxLines,
        bool isExpanded = false,
        int? flex,
        EdgeInsetsGeometry? padding,
        BoxDecoration? containerDecoration,
        Color? containerColor,
        EdgeInsetsGeometry? containerMargin,
        Widget Function(Widget child)? customWrapper,
      })  : _style = style,
        _textAlign = textAlign,
        _overflow = overflow,
        _maxLines = maxLines,
        _isExpanded = isExpanded,
        _flex = flex,
        _padding = padding,
        _containerDecoration = containerDecoration,
        _containerColor = containerColor,
        _containerMargin = containerMargin,
        _customWrapper = customWrapper;

  TextBuilder copyWith({
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? isExpanded,
    int? flex,
    EdgeInsetsGeometry? padding,
    BoxDecoration? containerDecoration,
    Color? containerColor,
    EdgeInsetsGeometry? containerMargin,
    Widget Function(Widget child)? customWrapper,
  }) {
    return TextBuilder(
      _text,
      style: style ?? _style,
      textAlign: textAlign ?? _textAlign,
      overflow: overflow ?? _overflow,
      maxLines: maxLines ?? _maxLines,
      isExpanded: isExpanded ?? _isExpanded,
      flex: flex ?? _flex,
      padding: padding ?? _padding,
      containerDecoration: containerDecoration ?? _containerDecoration,
      containerColor: containerColor ?? _containerColor,
      containerMargin: containerMargin ?? _containerMargin,
      customWrapper: customWrapper ?? _customWrapper,
    );
  }

  TextBuilder style(TextStyle s) => copyWith(style: s);
  TextBuilder color(Color c) => copyWith(style: (_style ?? const TextStyle()).copyWith(color: c));
  TextBuilder size(double size) => copyWith(style: (_style ?? const TextStyle()).copyWith(fontSize: size));
  TextBuilder weight(FontWeight w) => copyWith(style: (_style ?? const TextStyle()).copyWith(fontWeight: w));
  TextBuilder align(TextAlign a) => copyWith(textAlign: a);
  TextBuilder overflow(TextOverflow o) => copyWith(overflow: o);
  TextBuilder maxLines(int lines) => copyWith(maxLines: lines);

  // --- New Layout Capabilities ---

  /// Wraps the resulting text in an Expanded widget.
  TextBuilder expanded() => copyWith(isExpanded: true);

  /// Wraps the resulting text in a Flexible widget.
  TextBuilder flexible({int flex = 1}) => copyWith(flex: flex);

  /// Applies padding around the text.
  TextBuilder padded(EdgeInsetsGeometry padding) => copyWith(padding: padding);

  /// Wraps the text in a container with optional styling.
  TextBuilder insideContainer({
    Color? color,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? margin,
  }) => copyWith(
    containerColor: color,
    containerDecoration: decoration,
    containerMargin: margin,
  );

  /// Injects a custom wrapper function.
  TextBuilder wrapped(Widget Function(Widget child) wrapper) => copyWith(customWrapper: wrapper);

  Widget build() {
    Widget widget = Text(
      _text,
      style: _style,
      textAlign: _textAlign,
      overflow: _overflow,
      maxLines: _maxLines,
    );

    if (_padding != null) {
      widget = Padding(padding: _padding!, child: widget);
    }

    if (_containerColor != null || _containerDecoration != null || _containerMargin != null) {
      widget = Container(
        color: _containerColor,
        decoration: _containerDecoration,
        margin: _containerMargin,
        child: widget,
      );
    }

    if (_customWrapper != null) {
      widget = _customWrapper!(widget);
    }

    if (_isExpanded) {
      return Expanded(flex: _flex ?? 1, child: widget);
    }

    if (_flex != null) {
      return Flexible(flex: _flex!, child: widget);
    }

    return widget;
  }
}