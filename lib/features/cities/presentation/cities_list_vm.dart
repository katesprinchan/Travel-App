import 'package:flutter/material.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/features/settings/presentation/settings_modal_bs.dart';

class CityListViewModel {
  final SettingsService _settingsService;

  CityListViewModel({
    required SettingsService settingService,
  }) : _settingsService = settingService;

  void dispose() {}

  void onSettingsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          SettingsModalBottomSheet(settingsService: _settingsService),
      showDragHandle: true,
    );
  }
}
