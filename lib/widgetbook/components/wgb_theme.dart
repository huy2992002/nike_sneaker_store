import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/themes/ns_color_theme.dart';
import 'package:nike_sneaker_store/themes/ns_text_theme.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Theme',
  type: NSColorTheme,
)
Widget nsColorTheme(BuildContext context) {
  Widget colorTitle(Color color, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }

  return ListView(
    padding: const EdgeInsets.all(50),
    children: [
      colorTitle(
        Theme.of(context).colorScheme.primary,
        'Primary',
      ),
      colorTitle(
        Theme.of(context).colorScheme.onPrimary,
        'On Primary',
      ),
      colorTitle(
        Theme.of(context).colorScheme.primaryContainer,
        'Primary Container',
      ),
      colorTitle(
        Theme.of(context).colorScheme.onPrimaryContainer,
        'On Primary Container',
      ),
      colorTitle(
        Theme.of(context).colorScheme.secondary,
        'Secondary',
      ),
      colorTitle(
        Theme.of(context).colorScheme.onSecondary,
        'On Secondary',
      ),
      colorTitle(
        Theme.of(context).colorScheme.error,
        'Error',
      ),
      colorTitle(
        Theme.of(context).colorScheme.inverseSurface,
        'Inverse Surface',
      ),
      colorTitle(
        Theme.of(context).colorScheme.onInverseSurface,
        'On Inverse Surface',
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Theme',
  type: NSTextTheme,
)
Widget nsTextTheme(BuildContext context) {
  Widget typography(TextStyle? textStyle) {
    String text = 'There Are Many Beautiful And Attractive Plants To Your Room';
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  return ListView(
    padding: const EdgeInsets.all(50),
    children: [
      typography(Theme.of(context).textTheme.displayMedium),
      typography(Theme.of(context).textTheme.displaySmall),
      typography(Theme.of(context).textTheme.headlineLarge),
      typography(Theme.of(context).textTheme.headlineMedium),
      typography(Theme.of(context).textTheme.headlineSmall),
      typography(Theme.of(context).textTheme.titleLarge),
      typography(Theme.of(context).textTheme.titleMedium),
      typography(Theme.of(context).textTheme.titleSmall),
      typography(Theme.of(context).textTheme.bodyLarge),
      typography(Theme.of(context).textTheme.bodyMedium),
      typography(Theme.of(context).textTheme.bodySmall),
    ],
  );
}
