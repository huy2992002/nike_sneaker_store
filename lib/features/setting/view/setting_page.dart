import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/ns_switch.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_bloc.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_event.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/services/local/shared_pref.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController dropdownController = TextEditingController();
    List<String> language = [LanguageType.en.name, LanguageType.vi.name];
    dropdownController.text =
        SharedPrefs.isVietnamese ? LanguageType.vi.name : LanguageType.en.name;

    return Scaffold(
      appBar: NSAppBar(
        title: AppLocalizations.of(context).setting,
        leftIcon: NsIconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(
            Assets.icons.icArrow,
            width: getValueForScreenType(
              context: context,
              mobile: 24,
              tablet: 28,
            ),
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context).changeTheme,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              NSSwitch(
                onChanged: () {
                  context.read<SettingBloc>().add(SettingThemeChanged(
                        theme: SharedPrefs.isDark
                            ? ThemeMode.light
                            : ThemeMode.dark,
                      ));
                  SharedPrefs.isDark = !SharedPrefs.isDark;
                },
                isDark: SharedPrefs.isDark,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Text(
                AppLocalizations.of(context).changeLanguage,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              DropdownMenu(
                controller: dropdownController,
                dropdownMenuEntries: List.generate(
                  language.length,
                  (index) => DropdownMenuEntry(
                    value: language[index],
                    label: language[index],
                  ),
                ),
                onSelected: (value) {
                  if (value == LanguageType.vi.name) {
                    context.read<SettingBloc>().add(SettingLocaleChanged(
                            locale: Locale(
                          value ?? 'vi',
                        )));
                    SharedPrefs.isVietnamese = true;
                  } else {
                    context.read<SettingBloc>().add(SettingLocaleChanged(
                            locale: Locale(
                          value ?? 'en',
                        )));
                    SharedPrefs.isVietnamese = false;
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () => context.push(NSRoutesConst.pathChangePassword),
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context).changePassword,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                const Icon(Icons.arrow_right_alt)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum LanguageType { vi, en }
