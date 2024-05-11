import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/themes/ns_theme.dart';
import 'package:nike_sneaker_store/widgetbook/widgetbook.directories.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void main() {
  runApp(const WidgetBookApp());
}

@widgetbook.App()
class WidgetBookApp extends StatelessWidget {
  const WidgetBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    NSTheme nsTheme = NSTheme();
    return Widgetbook.material(
      directories: directories,
      addons: [
        DeviceFrameAddon(
          initialDevice: Devices.ios.iPhone13,
          devices: [
            NoneDevice.instance,
            Devices.ios.iPhone13,
            Devices.android.samsungGalaxyA50,
            Devices.ios.iPad12InchesGen2,
          ],
        ),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: nsTheme.lightTheme(context),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: nsTheme.darkTheme(context),
            ),
          ],
          initialTheme: WidgetbookTheme(
            name: 'Dark',
            data: nsTheme.darkTheme(context),
          ),
        ),
        LocalizationAddon(
          locales: [
            ...AppLocalizations.supportedLocales,
            const Locale('en', 'vn'),
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
        AlignmentAddon(),
      ],
    );
  }
}
