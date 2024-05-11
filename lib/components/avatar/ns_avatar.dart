import 'package:flutter/material.dart';

class NSAvatar extends StatelessWidget {
  /// Creates a circle that represents a user
  /// 
  /// The [imagePath] arguments must not be null.
  /// The default value [radius] arguments is 48.
  const NSAvatar({
    required this.imagePath,
    this.radius = 48,
    super.key,
  });

  /// [imagePath] is assetName of [AssetImage]
  final String imagePath;

  // [radius] is radius of avatar
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(imagePath),
    );
  }
}
