import 'package:flutter/material.dart';

class NsIconButton extends StatelessWidget {
  /// Create an [IconButton]
  ///
  /// The [onPressed] and [icon] arguments must not be null.
  const NsIconButton({
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    super.key,
  });

  /// Action when click onTap Widget
  final Function()? onPressed;

  /// Widget icon of button
  final Widget icon;

  /// Color of background button
  ///
  /// If [backgroundColor] argument is null, The default color is [Theme.of(context).colorScheme.secondaryContainer]
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor ??
              Theme.of(context).colorScheme.secondaryContainer,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
