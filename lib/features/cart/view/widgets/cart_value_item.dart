import 'package:flutter/material.dart';

class CartValueItem extends StatelessWidget {
  const CartValueItem({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontFamily: 'Poppins',
              ),
        ),
      ],
    );
  }
}
