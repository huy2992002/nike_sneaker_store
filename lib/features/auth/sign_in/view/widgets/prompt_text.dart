import 'package:flutter/material.dart';

class PromptText extends StatelessWidget {
  /// The text consists of 2 parts. 
  /// Prompt and [TextButton]
  /// 
  /// The [text], [title] arguments must not be null.
  const PromptText({
    required this.text,
    required this.title,
    this.onTap,
    super.key,
  });

  /// The text prompt
  final String text;

  /// The title of [TextButton]
  final String title;

  /// Action when click onTap of widget
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
