import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingState extends Equatable {
  const SettingState({
    required this.themeMode,
    required this.locale,
  });

  final ThemeMode themeMode;
  final Locale locale;

  SettingState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return SettingState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];
}
