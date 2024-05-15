import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/features/cities/presentation/cities_detail_pade.dart';
import 'package:travel_application/features/cities/presentation/list_page.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/routing.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final SettingsService settingsService;

  const DetailPage({super.key, required this.settingsService});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  SettingsService get settingsService => widget.settingsService;
  final placeName = PlaceName.placeName;
  final listName = ListName.listName;

  int numComments = 0;
  Future<String> getIdPlace() async {
    var snapshot = await FirebaseFirestore.instance
        .collection(listName)
        .where('name', isEqualTo: placeName)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    } else {
      return '';
    }
  }

  Widget _placeInfo(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(listName)
            .where('name', isEqualTo: placeName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('Документ не найден');
          } else {
            var data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
            IdDocPlace.id = snapshot.data!.docs.first.id;

            String selectedLanguage =
                settingsService.currentLocale.languageCode;
            var textInfo = '';
            var address = '';

            var number = data['number'] ?? '';
            var website = data['website'] ?? '';
            if (selectedLanguage == 'en') {
              textInfo = data['info_en'] ?? '';
              address = data['address_en'] ?? '';
            } else {
              textInfo = data['info'] ?? '';
              address = data['address'] ?? '';
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textInfo,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(height: 10),
                  if (address.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                address,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  if (number.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.phone,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                number,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  if (website.isNotEmpty)
                    InkWell(
                      onTap: () async {
                        if (website.isNotEmpty) {
                          try {
                            if (await canLaunchUrl(Uri.parse(website))) {
                              await launchUrl(Uri.parse(website));
                            } else {
                              throw 'Не удалось открыть ссылку: $website';
                            }
                          } catch (e) {
                            print('Ошибка при попытке открыть ссылку: $e');
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.public,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            S.of(context).webSite,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }
        },
      );
  Widget _getComments() {
    return FutureBuilder<String>(
      future: getIdPlace(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null) {
          return const Text('No id available');
        } else {
          String idPlace = snapshot.data!;
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection(listName)
                .doc(idPlace)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (!snapshot.hasData) {
                return const Text('No data available');
              } else {
                var data = snapshot.data!.data();

                if (data == null || data['Comments'] == null) {
                  return Row(
                    children: [
                      const SizedBox(width: 8),
                      Icon(Icons.comment,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        S.of(context).comments,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '($numComments)',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  );
                } else {
                  var comments = data['Comments'] as List<dynamic>;
                  numComments = comments.length;
                  return Column(
                    children: comments.map<Widget>((comment) {
                      return _buildCommentItem(comment);
                    }).toList(),
                  );
                }
              }
            },
          );
        }
      },
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            Icon(Icons.comment, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              S.of(context).comments,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(width: 8),
            Text(
              '($numComments)',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
        ListTile(
          leading: comment['ProfileImageURL'] != null &&
                  comment['ProfileImageURL'] is String
              ? CircleAvatar(
                  backgroundImage: NetworkImage(comment['ProfileImageURL']),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: Icon(
                    Icons.account_box_rounded,
                    size: 90,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
          title: Text(
            comment['FullName'],
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment['date'],
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                comment['comment'],
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (comment['image'] != null && comment['image'] is String)
          Image.network(
            comment['image'],
            height: 100,
            width: 100,
          ),
      ],
    );
  }

  Widget _getTitle() => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(listName)
            .where('name', isEqualTo: placeName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('Документ не найден');
          } else {
            var data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_placeInfo(context), _getComments()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          // createDocuments();
          context.go(AppRouteList.addCommentPage);
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

Future<void> createDocuments() async {
  try {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Attractions');
    List<Map<String, dynamic>> documentsData = [
      {
        'name': '',
        'name_en': '',
        'info': '',
        'info_en': '',
        'address': '',
        'address_en': '',
        'number': '',
        'website': '',
        'city': 'Tiraspol'
      },
    ];

    for (var data in documentsData) {
      DocumentReference documentRef = collection.doc();

      await documentRef.set(data);
    }

    print('Documents created successfully');
  } catch (e) {
    print('Error creating documents: $e');
  }
}

class IdDocPlace {
  static String id = '';
}
