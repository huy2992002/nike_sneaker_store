import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/components/avatar/ns_image_network.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/utils/extension.dart';

class CardCartProduct extends StatelessWidget {
  /// Create card item of Cart for
  ///
  /// The [product] arguments must not be null.
  const CardCartProduct({
    required this.product,
    this.onTap,
    this.onPlus,
    this.onLess,
    super.key,
  });

  /// Object [ProductModel]
  final ProductModel product;

  /// Action when click onTap Widget
  ///
  /// The [onTap] argument can null
  final Function()? onTap;

  /// Action when click onTap icon plus
  ///
  /// The [onPlus] argument can null
  final Function()? onPlus;

  /// Action when click onTap icon less
  ///
  /// The [onLess] argument can null
  final Function()? onLess;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: NSImageNetwork(
              path: product.imagePath,
              width: 77,
              height: 77,
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  (product.price ?? 0).toPriceDollar(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Row(
            children: [
              iconButton(
                context,
                iconPath: Assets.icons.icAdd,
                onTap: onPlus,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  '${product.quantity}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              iconButton(
                context,
                iconPath: Assets.icons.icRemove,
                onTap: onLess,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget iconButton(
    BuildContext context, {
    required String iconPath,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          iconPath,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
