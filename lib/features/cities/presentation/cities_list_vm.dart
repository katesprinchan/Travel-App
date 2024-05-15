import 'package:flutter/material.dart';
import 'package:travel_application/features/filter/domain/service/filter_service.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/features/settings/presentation/settings_modal_bs.dart';

class CityListViewModel {
  final FilterService _filterService;
  final SettingsService _settingsService;
  late TabController tabController;

  CityListViewModel({
    required FilterService filterService,
    required SettingsService settingService,
  })  : _filterService = filterService,
        _settingsService = settingService;

  void init({
    required final TabController tabController,
  }) {
    this.tabController = tabController;
  }

  void dispose() {}

  // void onFilterTap(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) =>
  //         FilterModalBottomSheet(filterService: _filterService),
  //     showDragHandle: true,
  //   );
  // }

  void onSettingsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          SettingsModalBottomSheet(settingsService: _settingsService),
      showDragHandle: true,
    );
  }
}
