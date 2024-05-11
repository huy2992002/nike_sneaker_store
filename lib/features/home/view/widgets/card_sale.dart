import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';

class CardSale extends StatelessWidget {
  /// Create card sale item of advertising banner advertising
  ///
  /// The [title], [discount], [imagePath] arguments must not be null.
  const CardSale({
    required this.title,
    required this.discount,
    required this.imagePath,
    super.key,
  });

  /// Display title of banner
  final String title;

  /// Percent discount of banner
  final int discount;

  /// [imagePath] is assetName of [AssetImage] display the product represents the banner
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      AppLocalizations.of(context).discountOff(discount),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 20,
          child: Image.asset(imagePath),
        ),
      ],
    );
  }
}
