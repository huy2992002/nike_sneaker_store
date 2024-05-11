import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class NSDrawer extends StatelessWidget {
  /// The custom drawer
  ///
  /// The [menuScreen] & [mainScreen] arguments must not be null.
  const NSDrawer({
    required this.menuScreen,
    required this.mainScreen,
    this.controller,
    super.key,
  });

  /// Controls the zoom drawer.
  final ZoomDrawerController? controller;

  /// Screen display menu
  final Widget menuScreen;

  /// Screen main
  final Widget mainScreen;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller,
      menuScreen: menuScreen,
      mainScreen: mainScreen,
      mainScreenTapClose: true,
      angle: -5,
      menuBackgroundColor: Theme.of(context).colorScheme.secondary,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          blurRadius: 2,
        )
      ],
    );
  }
}
