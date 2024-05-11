import 'package:flutter/material.dart';

class TitleLabel extends StatelessWidget {
  /// The text displays the label [TextFormField]
  /// 
  /// The [text] arguments must not be null.
  const TitleLabel({required this.text, super.key});

  /// The text display
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
  }
}
