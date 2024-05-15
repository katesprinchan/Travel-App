import 'package:flutter/material.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/button/app_bar_action_button.dart';
import 'package:travel_application/theme/colors_collection.dart';

class CustomSearchBar extends StatelessWidget {
  final Function() onFilterTap;

  const CustomSearchBar({
    Key? key,
    required this.onFilterTap,
  }) : super(key: key);

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: S.of(context).searchForAdvertisement,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsCollection.outline,
                    ),
                fillColor: ColorsCollection.surfaceContainerLow,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => openDrawer(context),
                ),
                prefixIconColor: ColorsCollection.outline,
              ),
            ),
          ),
          const SizedBox(width: 22),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsCollection.surfaceContainerLow,
            ),
            child: AppBarActionButton(
              onTap: onFilterTap,
              child: const Icon(Icons.filter_alt_outlined,
                  color: ColorsCollection.outline),
            ),
          ),
        ],
      ),
    );
  }
}
