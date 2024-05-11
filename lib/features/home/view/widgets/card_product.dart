import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/components/avatar/ns_image_network.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/utils/extension.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CardProduct extends StatelessWidget {
  /// Create card item of [CardProduct]
  ///
  /// The [product] arguments must not be null.
  const CardProduct({
    required this.product,
    this.onTap,
    this.onFavorite,
    this.onAddCart,
    this.tag,
    this.constraints,
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

  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              
            ),
            constraints: constraints,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (onFavorite != null)
                  GestureDetector(
                    onTap: onFavorite,
                    child: SvgPicture.asset(
                      product.isFavorite
                          ? Assets.icons.icHeart
                          : Assets.icons.icFavoriteOutline,
                      width: getValueForScreenType(
                        context: context,
                        mobile: 16,
                        tablet: 20,
                      ),
                    ),
                  ),
                Hero(
                  tag: tag ?? '',
                  child: NSImageNetwork(path: product.imagePath),
                ),
                const SizedBox(height: 12),
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
                Text(
                  product.name ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  (product.price ?? 0).toPriceDollar(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          if (onAddCart != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
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
                    width: getValueForScreenType(
                      context: context,
                      mobile: 14,
                      tablet: 18,
                    ),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CardProductLoading extends StatelessWidget {
  const CardProductLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 186,
      width: 152,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Center(
            child: ContainerLoading(
              width: 90,
              height: 48,
            ),
          ),
          SizedBox(height: 16),
          ContainerLoading(
            width: 80,
            height: 17,
          ),
          SizedBox(height: 10),
          ContainerLoading(
            width: 110,
            height: 20,
          ),
        ],
      ),
    );
  }
}

class ContainerLoading extends StatelessWidget {
  const ContainerLoading({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
