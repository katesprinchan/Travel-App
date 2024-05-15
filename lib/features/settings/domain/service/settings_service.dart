import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_application/features/settings/domain/entity/app_locale.dart';
import 'package:travel_application/features/settings/domain/service/settings_event.dart';
import 'package:travel_application/features/settings/domain/service/settings_state.dart';

class SettingsService extends Bloc<SettingsEvent, SettingsState> {
  SettingsService(super.initialState) {
    on<ChangeLocaleEvent>(_onChangeLocaleEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);
  }

  final List<AppLocale> supportedLocaleList = [
    const AppLocale(
      name: 'Русский',
      languageCode: 'ru',
    ),
    const AppLocale(
      name: 'English',
      languageCode: 'en',
    )
  ];

  AppLocale get currentLocale => supportedLocaleList[state.localeIndex];
  bool get currentTheme => state.isDarkMode;

  Future<void> _onChangeLocaleEvent(
    ChangeLocaleEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsState(
      localeIndex: event.newLocaleIndex,
      isDarkMode: state.isDarkMode,
    ));
  }

  Future<void> _onChangeThemeEvent(
    ChangeThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsState(
      localeIndex: state.localeIndex,
      isDarkMode: event.isDarkMode,
    ));
  }
}
