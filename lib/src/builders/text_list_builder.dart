import 'package:flutter/material.dart';

/// Configuration for specific items in the list builder.
@immutable
class ItemLayoutConfig {
  final bool isExpanded;
  final int? flex;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;
  final Color? containerColor;
  final Widget Function(Widget child)? wrapper;

  const ItemLayoutConfig({
    this.isExpanded = false,
    this.flex,
    this.padding,
    this.decoration,
    this.margin,
    this.containerColor,
    this.wrapper,
  });

  ItemLayoutConfig copyWith({
    bool? isExpanded,
    int? flex,
    EdgeInsetsGeometry? padding,
    Decoration? decoration,
    EdgeInsetsGeometry? margin,
    Color? containerColor,
    Widget Function(Widget child)? wrapper,
  }) {
    return ItemLayoutConfig(
      isExpanded: isExpanded ?? this.isExpanded,
      flex: flex ?? this.flex,
      padding: padding ?? this.padding,
      decoration: decoration ?? this.decoration,
      margin: margin ?? this.margin,
      containerColor: containerColor ?? this.containerColor,
      wrapper: wrapper ?? this.wrapper,
    );
  }
}

/// A fluent builder for creating rows or columns of text widgets from a list of strings.
///
/// Supports per-item configuration for layout, padding, and containment.
@immutable
class TextListBuilder {
  final List<String> _strings;
  final Axis _axis;
  final MainAxisAlignment _mainAxisAlignment;
  final CrossAxisAlignment _crossAxisAlignment;
  final MainAxisSize _mainAxisSize;
  final TextStyle? _style;
  final TextAlign? _textAlign;
  final double _spacing;
  final Map<int, ItemLayoutConfig> _itemConfigs;

  const TextListBuilder(
      this._strings, {
        Axis axis = Axis.vertical,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
        MainAxisSize mainAxisSize = MainAxisSize.max,
        TextStyle? style,
        TextAlign? textAlign,
        double spacing = 0.0,
        Map<int, ItemLayoutConfig> itemConfigs = const {},
      })  : _axis = axis,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        _mainAxisSize = mainAxisSize,
        _style = style,
        _textAlign = textAlign,
        _spacing = spacing,
        _itemConfigs = itemConfigs;

  /// Creates a copy with updated values.
  TextListBuilder copyWith({
    Axis? axis,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
    TextStyle? style,
    TextAlign? textAlign,
    double? spacing,
    Map<int, ItemLayoutConfig>? itemConfigs,
  }) {
    return TextListBuilder(
      _strings,
      axis: axis ?? _axis,
      mainAxisAlignment: mainAxisAlignment ?? _mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? _crossAxisAlignment,
      mainAxisSize: mainAxisSize ?? _mainAxisSize,
      style: style ?? _style,
      textAlign: textAlign ?? _textAlign,
      spacing: spacing ?? _spacing,
      itemConfigs: itemConfigs ?? _itemConfigs,
    );
  }

  // --- Global Configuration ---

  TextListBuilder style(TextStyle style) => copyWith(style: style);
  TextListBuilder align(TextAlign align) => copyWith(textAlign: align);
  TextListBuilder spacing(double spacing) => copyWith(spacing: spacing);
  TextListBuilder mainAxis(MainAxisAlignment alignment) =>
      copyWith(mainAxisAlignment: alignment);
  TextListBuilder crossAxis(CrossAxisAlignment alignment) =>
      copyWith(crossAxisAlignment: alignment);

  // --- Per-Index Configuration ---

  TextListBuilder _updateConfig(int index, ItemLayoutConfig Function(ItemLayoutConfig) update) {
    final newConfigs = Map<int, ItemLayoutConfig>.from(_itemConfigs);
    final currentConfig = newConfigs[index] ?? const ItemLayoutConfig();
    newConfigs[index] = update(currentConfig);
    return copyWith(itemConfigs: newConfigs);
  }

  /// Wraps the item at [index] with an [Expanded] widget.
  TextListBuilder expandAt(int index) =>
      _updateConfig(index, (c) => c.copyWith(isExpanded: true));

  /// Wraps the item at [index] with a [Flexible] widget.
  TextListBuilder flexibleAt(int index, {int flex = 1}) =>
      _updateConfig(index, (c) => c.copyWith(flex: flex));

  /// Applies padding to the item at [index].
  TextListBuilder paddingAt(int index, EdgeInsetsGeometry padding) =>
      _updateConfig(index, (c) => c.copyWith(padding: padding));

  /// Wraps the item at [index] in a Container with optional properties.
  TextListBuilder containerAt(int index, {
    Color? color,
    Decoration? decoration,
    EdgeInsetsGeometry? margin,
  }) =>
      _updateConfig(index, (c) => c.copyWith(
        containerColor: color,
        decoration: decoration,
        margin: margin,
      ));

  /// Injects a custom wrapper function for the item at [index].
  ///
  /// The [wrapper] function takes the built child (Text wrapped in padding/container)
  /// and returns a new Widget. This is applied BEFORE Expanded/Flexible.
  TextListBuilder wrapAt(int index, Widget Function(Widget child) wrapper) =>
      _updateConfig(index, (c) => c.copyWith(wrapper: wrapper));

  /// Builds the Flex widget (Row or Column).
  Widget build() {
    List<Widget> children = [];
    for (int i = 0; i < _strings.length; i++) {
      final text = _strings[i];
      final config = _itemConfigs[i];

      // 1. Base Text
      Widget item = Text(
        text,
        style: _style,
        textAlign: _textAlign,
      );

      if (config != null) {
        // 2. Padding
        if (config.padding != null) {
          item = Padding(padding: config.padding!, child: item);
        }

        // 3. Container (Color/Decoration/Margin)
        if (config.containerColor != null ||
            config.decoration != null ||
            config.margin != null) {
          item = Container(
            color: config.containerColor,
            decoration: config.decoration,
            margin: config.margin,
            child: item,
          );
        }

        // 4. Custom Wrapper
        if (config.wrapper != null) {
          item = config.wrapper!(item);
        }

        // 5. Flex / Expanded (Must be direct child of Row/Column)
        if (config.isExpanded) {
          item = Expanded(flex: config.flex ?? 1, child: item);
        } else if (config.flex != null) {
          item = Flexible(flex: config.flex!, child: item);
        }
      }

      children.add(item);

      // Add Spacing
      if (_spacing > 0 && i < _strings.length - 1) {
        children.add(SizedBox(
          width: _axis == Axis.horizontal ? _spacing : 0,
          height: _axis == Axis.vertical ? _spacing : 0,
        ));
      }
    }

    return Flex(
      direction: _axis,
      mainAxisAlignment: _mainAxisAlignment,
      crossAxisAlignment: _crossAxisAlignment,
      mainAxisSize: _mainAxisSize,
      children: children,
    );
  }

  /// Converts to a Column widget.
  Column toColumn() {
    if (_axis != Axis.vertical) {
      return copyWith(axis: Axis.vertical).build() as Column;
    }
    return build() as Column;
  }

  /// Converts to a Row widget.
  Row toRow() {
    if (_axis != Axis.horizontal) {
      return copyWith(axis: Axis.horizontal).build() as Row;
    }
    return build() as Row;
  }
}