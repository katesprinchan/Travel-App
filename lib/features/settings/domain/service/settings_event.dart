abstract class SettingsEvent {
  const SettingsEvent();
}

class ChangeLocaleEvent extends SettingsEvent {
  final int newLocaleIndex;

  const ChangeLocaleEvent(this.newLocaleIndex);
}

class ChangeThemeEvent extends SettingsEvent {
  final bool isDarkMode;

  const ChangeThemeEvent(this.isDarkMode);
}
