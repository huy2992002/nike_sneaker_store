import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_bloc.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_event.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_state.dart';
import 'package:nike_sneaker_store/services/local/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SettingBloc settingBloc;

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'themeKey': true,
      'languageKey': true,
    });
    await SharedPrefs.initialization();

    settingBloc = SettingBloc();
  });

  group('Setting Bloc Test', () {
    test('initial state is Setting Bloc', () {
      expect(
          settingBloc.state,
          equals(const SettingState(
            themeMode: ThemeMode.dark,
            locale: Locale('vi'),
          )));
    });

    blocTest(
      'emit changed theme when on pressed',
      build: () => settingBloc,
      act: (bloc) {
        bloc.add(SettingThemeChanged(theme: ThemeMode.light));
      },
      expect: () => [
        const SettingState(themeMode: ThemeMode.light, locale: Locale('vi'))
      ],
    );

    blocTest(
      'emit changed language when on pressed',
      build: () => settingBloc,
      act: (bloc) {
        bloc.add(SettingLocaleChanged(locale: const Locale('en')));
      },
      expect: () =>
          [const SettingState(themeMode: ThemeMode.dark, locale: Locale('en'))],
    );
  });
}
