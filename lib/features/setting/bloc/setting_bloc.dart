import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_event.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_state.dart';
import 'package:nike_sneaker_store/services/local/shared_pref.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(
          SettingState(
            themeMode: SharedPrefs.isDark ? ThemeMode.dark : ThemeMode.light,
            locale: SharedPrefs.isVietnamese
                ? const Locale('vi')
                : const Locale('en'),
          ),
        ) {
    on<SettingThemeChanged>(_onThemeChanged);
    on<SettingLocaleChanged>(_onLocaleChanged);
  }

  Future<void> _onThemeChanged(
    SettingThemeChanged event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.theme));
  }

  Future<void> _onLocaleChanged(
    SettingLocaleChanged event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(locale: event.locale));
  }
}
