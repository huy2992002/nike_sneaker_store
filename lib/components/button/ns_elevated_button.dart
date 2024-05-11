import 'package:flutter/material.dart';

class NSElevatedButton extends StatelessWidget {
  /// Create an [ElevatedButton]
  ///
  /// The [onPressed] and [text] arguments must not be null.
  const NSElevatedButton.text({
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.isDisable = false,
    super.key,
  });

  /// Create [ElevatedButton] with Icon for app Nike Sneaker
  /// The distance between [icon] and [text] is 16
  ///
  /// The [onPressed], [icon] and [text] arguments must not be null.
  factory NSElevatedButton.icon({
    required Widget icon,
    required String text,
    Function()? onPressed,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
    bool? isDisable,
  }) {
    return NSElevatedButton.text(
      onPressed: onPressed,
      text: text,
      icon: icon,
      backgroundColor: backgroundColor,
      textColor: textColor,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      isDisable: isDisable ?? false,
    );
  }

  /// Action when click onTap Widget
  final Function()? onPressed;

  /// Title display of button
  final String text;

  /// Color of background button
  ///
  /// If [backgroundColor] argument is null, The default color is [Theme.of(context).colorScheme.primary]
  final Color? backgroundColor;

  /// Color of text button
  ///
  /// If [textColor] argument is null, The default color is [Theme.of(context).colorScheme.onPrimary]
  final Color? textColor;

  /// Widget icon of button
  ///
  /// If [icon] argument is null, no display right app bar
  final Widget? icon;

  /// Padding of button with content
  final EdgeInsetsGeometry padding;

  /// If [isDisable] argument is true, display [CircularProgressIndicator]
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable ? null : onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isDisable
            ? Center(
                child: SizedBox.square(
                  dimension: 19,
                  child: CircularProgressIndicator(
                    color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                    strokeWidth: 2.5,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 16),
                  ],
                  Text(
                    text,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: textColor ??
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
