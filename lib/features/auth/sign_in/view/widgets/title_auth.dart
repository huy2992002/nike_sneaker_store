import 'package:flutter/material.dart';

class TitleAuth extends StatelessWidget {
  /// The text displays the title of the page
  ///
  /// The [title], [subTitle] arguments must not be null.
  const TitleAuth({
    required this.title,
    required this.subTitle,
    super.key,
  });

  /// The title display
  final String title;

  /// The sub title display under title
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.surfaceTint,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
