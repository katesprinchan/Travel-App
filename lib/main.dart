import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_application/core/domain/container/app_container.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/routing.dart';
import 'package:travel_application/theme/theme_data.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppContainer.init();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(MyApp(
    appContainer: AppContainer(),
  ));
}

class MyApp extends StatelessWidget {
  final AppContainer appContainer;

  const MyApp({
    super.key,
    required this.appContainer,
  });

  SettingsService get settingsService =>
      appContainer.serviceScope.settingsService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => settingsService,
      child: BlocBuilder(
        bloc: settingsService,
        builder: (context, state) => MaterialApp.router(
          title: 'Отдыхай в Приднестровье',
          theme: settingsService.currentTheme ? darkTheme : lightTheme,
          routerConfig: AppRouterConfig.instance,
          localizationsDelegates: const [
            S.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: settingsService.currentLocale,
          supportedLocales: settingsService.supportedLocaleList,
        ),
      ),
    );
  }
}
