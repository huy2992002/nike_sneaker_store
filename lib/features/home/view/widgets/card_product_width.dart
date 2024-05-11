import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/components/avatar/ns_image_network.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/utils/extension.dart';

class CardProductWith extends StatelessWidget {
  /// Create card item of [CardProductWith]
  ///
  /// The [product] arguments must not be null.
  const CardProductWith({
    required this.product,
    this.onTap,
    this.onFavorite,
    this.onAddCart,
    this.tag,
    super.key,
  });

  /// [product] use display arguments of Object [ProductModel]
  final ProductModel product;

  /// Action when click onTap Widget
  ///
  /// The [onTap] argument can null
  final Function()? onTap;

  /// Action when click onTap icon heart
  ///
  ///The [onFavorite] argument can null
  final Function()? onFavorite;

  /// Action when click onTap icon plus add to cart
  ///
  ///The [onAddCart] argument can null
  final Function()? onAddCart;

  final String? tag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if (onFavorite != null)
              GestureDetector(
                onTap: onFavorite,
                child: product.isFavorite
                    ? SvgPicture.asset(Assets.icons.icHeart)
                    : SvgPicture.asset(
                        Assets.icons.icHeartOutline,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
              ),
            Hero(
              tag: tag ?? '',
              child: NSImageNetwork(
                path: product.imagePath,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (product.isBestSeller ?? true) ...[
                    Text(
                      'BEST SELLER',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    (product.price ?? 0).toPriceDollar(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (onAddCart != null)
              GestureDetector(
                onTap: onAddCart,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.icAdd,
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
