import 'package:flutter/material.dart';

class NsTextButton extends StatelessWidget {
  /// Create an [TextButton]
  ///
  /// The [onPressed] and [text] arguments must not be null.
  const NsTextButton({
    required this.text,
    this.onPressed,
    this.textStyle,
    super.key,
  });

  /// Action when click onTap Widget
  final Function()? onPressed;

  /// Title display of button
  final String text;

  /// Style of [text]
  ///
  /// If [textStyle] argument is null, The default style is [Theme.of(context).textTheme.labelSmall]
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: textStyle ??
            Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
      ),
    );
  }
}
