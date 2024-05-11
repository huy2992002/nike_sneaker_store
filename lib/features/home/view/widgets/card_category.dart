import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  /// Create card item of category
  ///
  /// The [text] arguments must not be null.
  const CardCategory({
    required this.text,
    this.onPressed,
    this.selected = false,
    super.key,
  });

  /// Title display of [CardCategory]
  final String text;

  /// Action when click onTap Widget
  ///
  /// The [onPressed] argument can null
  final Function()? onPressed;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 11),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: selected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
    );
  }
}
