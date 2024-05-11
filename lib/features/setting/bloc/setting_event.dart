import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SettingEvent extends Equatable {}

class SettingThemeChanged extends SettingEvent {
  SettingThemeChanged({required this.theme});

  final ThemeMode theme;

  @override
  List<Object?> get props => [theme];
}

class SettingLocaleChanged extends SettingEvent {
  SettingLocaleChanged({required this.locale});

  final Locale locale;

  @override
  List<Object?> get props => [locale];
}
