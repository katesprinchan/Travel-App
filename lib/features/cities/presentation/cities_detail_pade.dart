import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/app_filled_button.dart';
import 'package:travel_application/features/cities/presentation/cities_list_page.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/routing.dart';

class CitiesDetailPage extends StatefulWidget {
  final SettingsService settingsService;

  const CitiesDetailPage({super.key, required this.settingsService});

  @override
  State<CitiesDetailPage> createState() => _CitiesDetailPageState();
}

class _CitiesDetailPageState extends State<CitiesDetailPage>
    with SingleTickerProviderStateMixin {
  SettingsService get settingsService => widget.settingsService;
  final cityName = CityName.cityName;
  final id = IdDocCity.id;
  Widget _listIcon(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hotel,
                color: Theme.of(context).colorScheme.secondary, size: 90),
            const SizedBox(height: 20),
            AppFilledButton(
              onPressed: () {
                context.go(AppRouteList.listPage);
                ListName.listName = 'Hotels';
              },
              width: 230,
              child: Text(S.of(context).hotels),
            ),
            const SizedBox(height: 30),
            Icon(Icons.restaurant,
                color: Theme.of(context).colorScheme.secondary, size: 90),
            const SizedBox(height: 20),
            AppFilledButton(
              onPressed: () {
                context.go(AppRouteList.listPage);
                ListName.listName = 'Restaurants';
              },
              width: 230,
              child: Text(S.of(context).restaurants),
            ),
            const SizedBox(height: 30),
            Icon(Icons.camera_alt_rounded,
                color: Theme.of(context).colorScheme.secondary, size: 90),
            const SizedBox(height: 20),
            AppFilledButton(
              onPressed: () {
                context.go(AppRouteList.listPage);
                ListName.listName = 'Attractions';
              },
              width: 230,
              child: Text(S.of(context).attractions),
            ),
            const SizedBox(height: 30),
            // Icon(Icons.map_outlined,
            //     color: Theme.of(context).colorScheme.secondary, size: 90),
            // const SizedBox(height: 20),
            // AppFilledButton(
            //   onPressed: () {
            //     context.go(AppRouteList.listPage);
            //   },
            //   width: 230,
            //   child: Text(S.of(context).map),
            // ),
            const SizedBox(height: 30),
            Icon(Icons.sunny,
                color: Theme.of(context).colorScheme.secondary, size: 90),
            const SizedBox(height: 20),
            AppFilledButton(
              onPressed: () {
                context.go(AppRouteList.weather);
              },
              width: 230,
              child: Text(S.of(context).weather),
            ),
          ],
        ),
      );

  Widget _cityInfo(BuildContext context) => StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Cities').doc(id).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Документ не найден');
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            String selectedLanguage =
                settingsService.currentLocale.languageCode;
            var textInfo = '';
            if (selectedLanguage == 'en') {
              textInfo = data['info_en'] ?? '';
            } else {
              textInfo = data['info'] ?? '';
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textInfo,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
            );
          }
        },
      );

  Widget _getTitle() => StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Cities').doc(id).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Документ не найден');
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            String selectedLanguage =
                settingsService.currentLocale.languageCode;
            var title = '';
            if (selectedLanguage == 'en') {
              title = data['name_en'] ?? '';
            } else {
              title = data['name'] ?? '';
            }
            return Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            );
          }
        },
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getTitle(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _cityInfo(context),
            _listIcon(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

class ListName {
  static String listName = '';
}

class IdDocList {
  static String id = '';
}
