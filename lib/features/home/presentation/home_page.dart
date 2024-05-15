import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/routing.dart';

class HomePage extends StatelessWidget {
  final StatefulNavigationShell child;
  const HomePage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: child.currentIndex,
        onTap: (value) => _onBottomBarItemTap(value, context),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment_outlined),
            label: S.of(context).main,
            activeIcon: const Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            label: S.of(context).favorites,
            activeIcon: const Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            label: S.of(context).profile,
            activeIcon: const Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}

_onBottomBarItemTap(int value, BuildContext context) {
  switch (value) {
    case 0:
      return context.go(AppRouteList.citiesListPage);
    case 1:
      return context.go(AppRouteList.placeFavoritePage);
    case 2:
      return context.go(AppRouteList.profilePage);
  }
}
