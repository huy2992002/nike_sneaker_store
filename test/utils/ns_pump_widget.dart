import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/themes/ns_theme.dart';

class NsPumpWidget extends StatelessWidget {
  const NsPumpWidget({
    required this.home,
    super.key,
  });
  final Widget home;

  @override
  Widget build(BuildContext context) {
    NSTheme nsTheme = NSTheme();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      theme: nsTheme.lightTheme(context),
      home: home,
    );
  }
}
