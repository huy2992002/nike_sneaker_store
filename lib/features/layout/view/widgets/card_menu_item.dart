import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/gen/fonts.gen.dart';

class CardMenuItem extends StatelessWidget {
  /// Create card item of menu drawer
  ///
  /// The [title], [iconPath] arguments must not be null.
  const CardMenuItem({
    required this.title,
    required this.iconPath,
    this.onTap,
    super.key,
  });

  /// Title display of [CardMenuItem]
  final String title;

  /// [iconPath] is assetName of [SvgPicture.asset]
  final String iconPath;

  /// Action when click onTap Widget
  ///
  /// The [onTap] argument can null
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontFamily: FontFamily.raleway
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
