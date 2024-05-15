import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/features/cities/presentation/cities_detail_pade.dart';
import 'package:travel_application/features/cities/presentation/cities_list_page.dart';
import 'package:travel_application/features/cities/provider/favorite_provider.dart';
import 'package:travel_application/features/cities/widget/cardDecoration.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/routing.dart';

class ListPage extends StatefulWidget {
  final SettingsService settingsService;
  const ListPage({super.key, required this.settingsService});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  SettingsService get settingsService => widget.settingsService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getListText(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(ListName.listName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final place = documents[index];
                final documentId = place.id;
                String selectedLanguage =
                    settingsService.currentLocale.languageCode;

                if (place['city'] == CityName.cityName) {
                  var name = '';
                  var info = '';
                  if (selectedLanguage == 'en' &&
                      place['city'] == CityName.cityName) {
                    name = place['name_en'] ?? '';
                    info = place['info_en'] ?? '';
                  } else if (selectedLanguage == 'ru' &&
                      place['city'] == CityName.cityName) {
                    name = place['name'] ?? '';
                    info = place['info'] ?? '';
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        PlaceName.placeName = place['name'];
                        context.go(AppRouteList.detailPage);
                      },
                      child: Container(
                        width: 200,
                        decoration: cardDecoration(context),
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: FirebaseStorage.instance
                                  .ref()
                                  .child(
                                      '${ListName.listName}/${place['name_en']}.jpg')
                                  .getDownloadURL(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasError) {
                                  return Text('Ошибка: ${snapshot.error}');
                                }
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    snapshot.data.toString(),
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null
                                          ? child
                                          : const CircularProgressIndicator();
                                    },
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text(
                                name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    info,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    S.of(context).readMore,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                                ],
                              ),
                              trailing: Consumer<FavoriteProvider>(
                                builder: (context, favoriteProvider, _) {
                                  return FutureBuilder<bool>(
                                    future:
                                        favoriteProvider.isFavorite(documentId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.grey,
                                        );
                                      } else {
                                        final isFavorite =
                                            snapshot.data ?? false;
                                        return IconButton(
                                          onPressed: () {
                                            favoriteProvider
                                                .toggleFavorite(documentId);
                                          },
                                          icon: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons
                                                    .favorite_border_outlined,
                                            color: isFavorite
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                          ),
                                          iconSize: 24,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}

class PlaceName {
  static String placeName = '';
}

String getListText(context) {
  switch (ListName.listName) {
    case 'Hotels':
      return S.of(context).hotels;
    case 'Restaurants':
      return S.of(context).restaurants;
    case 'Attractions':
      return S.of(context).attractions;
    default:
      return 'Неизвестный список';
  }
}
