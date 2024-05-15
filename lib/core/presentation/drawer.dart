import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/routing.dart';

class MainDrawer extends StatelessWidget {
  final Function() onSettingsTap;
  const MainDrawer({
    Key? key,
    required this.onSettingsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          ListTile(
            leading:
                Image.asset('assets/image/trip.png', height: 28, width: 28),
            title: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ) ??
                  const TextStyle(),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(S.of(context).relaxInPridnestrovie),
                ],
                isRepeatingAnimation: false,
              ),
            ),
            onTap: onSettingsTap,
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined,
                color: Theme.of(context).colorScheme.outline),
            title: Text(
              S.of(context).settings,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            onTap: onSettingsTap,
          ),
          ListTile(
            leading: Icon(Icons.info_outline,
                color: Theme.of(context).colorScheme.outline),
            title: Text(
              S.of(context).aboutApplication,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            onTap: () {
              context.go(AppRouteList.aboutApplication);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app,
                color: Theme.of(context).colorScheme.outline),
            title: Text(
              S.of(context).goOut,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            onTap: () {
              context.go(AppRouteList.auth);
            },
          ),
        ],
      ),
    );
  }
}
