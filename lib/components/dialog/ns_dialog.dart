import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';

class NSDialog {
  NSDialog._();

  /// Create [Dialog] show message
  ///
  /// The [title] arguments is display title of [Dialog]
  ///
  /// The [content] arguments is display sub content
  ///
  /// The [contentTextStyle] argument is style of content
  /// If [actions] argument is List action
  static void dialog(
    BuildContext context, {
    Widget? title,
    Widget? content,
    TextStyle? contentTextStyle,
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(30),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          title: title,
          content: content,
          contentTextStyle:
              contentTextStyle ?? Theme.of(context).textTheme.titleLarge,
          actions: actions,
        );
      },
    );
  }

  static void dialogQuestion(
    BuildContext context, {
    required String title,
    Function()? action,
  }) {
    return NSDialog.dialog(
      context,
      content: Text(title),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NSElevatedButton.text(
              onPressed: () => context.pop(),
              text: AppLocalizations.of(context).no,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 14),
            NSElevatedButton.text(
              onPressed: () {
                action?.call();
                context.pop();
              },
              text: AppLocalizations.of(context).yes,
            ),
          ],
        ),
      ],
    );
  }
}
