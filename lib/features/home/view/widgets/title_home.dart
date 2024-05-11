import 'package:flutter/material.dart';

class TitleHome extends StatelessWidget {
  /// The text displays the title of the home page
  /// 
  /// The [text] arguments must not be null.
  const TitleHome({
    required this.text,
    this.padding,
    super.key,
  });

  /// The title display
  final String text;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 20, bottom: 14),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
