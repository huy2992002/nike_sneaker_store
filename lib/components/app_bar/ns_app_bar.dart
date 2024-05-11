import 'package:flutter/material.dart';

class NSAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Create design app bar with height 50px
  /// with title of app bar is [title], two icon left and right
  ///
  /// The [title] arguments must not be null.
  const NSAppBar({
    required this.title,
    this.leftIcon,
    this.rightIcon,
    this.colorAppBar,
    super.key,
  });

  /// The text to display center app bar
  final String title;

  /// Icon display left of app bar
  /// If [leftIcon] argument is null, no display left app bar
  final Widget? leftIcon;

  /// Icon display right of app bar
  /// If [rightIcon] argument is null, no display right app bar
  final Widget? rightIcon;

  /// [Color] of app bar
  ///
  /// If [colorAppBar] argument is null will use default color of Theme
  final Color? colorAppBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorAppBar,
      leading: leftIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20),
              child: leftIcon,
            )
          : const SizedBox(width: 44),
      leadingWidth: 64,
      title: Text(title),
      actions: [
        if (rightIcon != null) rightIcon! else const SizedBox(width: 44),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
