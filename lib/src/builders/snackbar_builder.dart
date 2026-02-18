import 'package:flutter/material.dart';

/// A fluent builder for creating SnackBars.
@immutable
class SnackbarBuilder {
  final String _text;
  final Color? _backgroundColor;
  final TextStyle? _textStyle;
  final Duration _duration;
  final SnackBarAction? _action;
  final SnackBarBehavior? _behavior;
  final EdgeInsetsGeometry? _margin;
  final double? _elevation;
  final ShapeBorder? _shape;
  final Animation<double>? _animation;
  final bool _showCloseIcon;
  final Color? _closeIconColor;

  const SnackbarBuilder(
      this._text, {
        Color? backgroundColor,
        TextStyle? textStyle,
        Duration duration = const Duration(seconds: 4),
        SnackBarAction? action,
        SnackBarBehavior? behavior,
        EdgeInsetsGeometry? margin,
        double? elevation,
        ShapeBorder? shape,
        Animation<double>? animation,
        bool showCloseIcon = false,
        Color? closeIconColor,
      })  : _backgroundColor = backgroundColor,
        _textStyle = textStyle,
        _duration = duration,
        _action = action,
        _behavior = behavior,
        _margin = margin,
        _elevation = elevation,
        _shape = shape,
        _animation = animation,
        _showCloseIcon = showCloseIcon,
        _closeIconColor = closeIconColor;

  SnackbarBuilder copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    Duration? duration,
    SnackBarAction? action,
    SnackBarBehavior? behavior,
    EdgeInsetsGeometry? margin,
    double? elevation,
    ShapeBorder? shape,
    Animation<double>? animation,
    bool? showCloseIcon,
    Color? closeIconColor,
  }) {
    return SnackbarBuilder(
      _text,
      backgroundColor: backgroundColor ?? _backgroundColor,
      textStyle: textStyle ?? _textStyle,
      duration: duration ?? _duration,
      action: action ?? _action,
      behavior: behavior ?? _behavior,
      margin: margin ?? _margin,
      elevation: elevation ?? _elevation,
      shape: shape ?? _shape,
      animation: animation ?? _animation,
      showCloseIcon: showCloseIcon ?? _showCloseIcon,
      closeIconColor: closeIconColor ?? _closeIconColor,
    );
  }

  SnackbarBuilder color(Color color) => copyWith(backgroundColor: color);
  SnackbarBuilder textColor(Color color) =>
      copyWith(textStyle: (_textStyle ?? const TextStyle()).copyWith(color: color));
  SnackbarBuilder duration(Duration duration) => copyWith(duration: duration);
  SnackbarBuilder action(String label, VoidCallback onPressed) =>
      copyWith(action: SnackBarAction(label: label, onPressed: onPressed));

  // --- New Capabilities ---

  /// Sets behavior to floating.
  SnackbarBuilder floating() => copyWith(behavior: SnackBarBehavior.floating);

  /// Sets behavior to fixed.
  SnackbarBuilder fixed() => copyWith(behavior: SnackBarBehavior.fixed);

  /// Applies margin (only works with floating behavior).
  SnackbarBuilder withMargin(EdgeInsetsGeometry margin) => copyWith(margin: margin);

  /// Applies custom shape.
  SnackbarBuilder withShape(ShapeBorder shape) => copyWith(shape: shape);

  /// Adds a close icon.
  SnackbarBuilder withCloseIcon({Color? color}) => copyWith(showCloseIcon: true, closeIconColor: color);

  SnackBar build() {
    return SnackBar(
      content: Text(_text, style: _textStyle),
      backgroundColor: _backgroundColor,
      duration: _duration,
      action: _action,
      behavior: _behavior,
      margin: _margin,
      elevation: _elevation,
      shape: _shape,
      animation: _animation,
      showCloseIcon: _showCloseIcon,
      closeIconColor: _closeIconColor,
    );
  }
}