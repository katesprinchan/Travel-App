import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/button/app_bar_action_button.dart';
import 'package:travel_application/core/presentation/drawer.dart';
import 'package:travel_application/features/profile/presentation/page/profile_vm.dart';
import 'package:travel_application/routing.dart';

class ProfilePage extends StatefulWidget {
  final ProfileViewModel vm;
  const ProfilePage({super.key, required this.vm});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  ProfileViewModel get vm => widget.vm;
  late ProfileViewModel _profileViewModel;

  @override
  void initState() {
    super.initState();
    _profileViewModel = widget.vm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).profile,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          AppBarActionButton(
            onTap: () => {context.go(AppRouteList.editingProfilePage)},
            child: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      drawer: MainDrawer(onSettingsTap: () {
        widget.vm.onSettingsTap(context);
      }),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _titleBuilder(context),
          const SizedBox(height: 16),
          _contentBuilder(context)
        ],
      ),
    );
  }

  Widget _imageBuilder() => StreamBuilder<String?>(
        stream: _profileViewModel.getURL(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final String? profileImageURL = snapshot.data;
            if (profileImageURL != null && profileImageURL.isNotEmpty) {
              return CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profileImageURL),
              );
            } else {
              return CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.background,
                child: Icon(Icons.account_box_rounded,
                    size: 90, color: Theme.of(context).colorScheme.primary),
              );
            }
          }
        },
      );

  Widget _titleBuilder(BuildContext context) => StreamBuilder<String?>(
        stream: _profileViewModel.getFullNameStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final String? fullName = snapshot.data;

            return Center(
              child: Column(
                children: [
                  _imageBuilder(),
                  const SizedBox(height: 12),
                  Text(
                    fullName ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ],
              ),
            );
          }
        },
      );

  Widget _contentBuilder(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'E-mail',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            FutureBuilder<String?>(
              future: _profileViewModel.getCurrentUserEmail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final String? email = snapshot.data;

                  return Text(
                    email ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).registrationDate,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            FutureBuilder<DateTime?>(
              future: _profileViewModel.getUserRegistrationDate(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final DateTime? registrationDate = snapshot.data;

                  return Text(
                    registrationDate != null
                        ? DateFormat.yMMMMd().format(registrationDate)
                        : S.of(context).registrationDateUnknown,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  );
                }
              },
            ),
          ],
        ),
      );
}
