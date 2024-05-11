import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/resources/ns_color.dart';
import 'package:nike_sneaker_store/resources/ns_style.dart';
import 'package:nike_sneaker_store/themes/ns_color_theme.dart';
import 'package:nike_sneaker_store/themes/ns_text_theme.dart';

class NSTheme {
  NSTheme();

  ThemeData lightTheme(BuildContext context) {
    NSTextTheme nsTextTheme = NSTextTheme();
    NSStyle nsStyle = NSStyle();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: NSColorTheme.colorThemeLight,
      textTheme: nsTextTheme.textTheme(context),
      appBarTheme: AppBarTheme(
        backgroundColor: NSColor.background,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle:
            nsStyle.h16SemiBold(context).copyWith(color: NSColor.onBackground),
      ),
      backgroundColor: NSColor.background,
      shadowColor: NSColor.onPrimaryContainer.withOpacity(0.4),
      dialogBackgroundColor: NSColor.background,
    );
  }

  ThemeData darkTheme(BuildContext context) {
    NSTextTheme nsTextTheme = NSTextTheme();
    NSStyle nsStyle = NSStyle();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: NSColorTheme.colorThemeDark,
      textTheme: nsTextTheme.textTheme(context),
      appBarTheme: AppBarTheme(
        backgroundColor: NSColor.darkBackground,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: nsStyle.h16SemiBold(context).copyWith(
              color: NSColor.darkOnBackground,
            ),
      ),
      backgroundColor: NSColor.darkBackground,
      shadowColor: NSColor.onPrimaryContainer.withOpacity(0.4),
      dialogBackgroundColor: NSColor.darkBackground,
    );
  }
}
