import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/components/avatar/ns_image_network.dart';
import 'package:nike_sneaker_store/models/notification_model.dart';
import 'package:nike_sneaker_store/utils/extension.dart';

class CardNotification extends StatelessWidget {
  /// Create card item of [NotificationModel]
  ///
  /// The [notification] arguments must not be null.
  const CardNotification({
    required this.notification,
    this.onTap,
    super.key,
  });

  /// [notification] use display arguments of Object [NotificationModel]
  final NotificationModel notification;

  /// Action when click onTap Widget
  ///
  /// The [onTap] argument can null
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 85,
              height: 85,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: NSImageNetwork(path: notification.product?.imagePath),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: notification.isRead
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.primary,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        (notification.product?.price ?? 0).toPriceDollar(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        notification.priceSale?.toPriceDollar() ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
