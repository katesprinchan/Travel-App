import 'package:flutter/material.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/features/filter/domain/service/filter_service.dart';
import 'package:travel_application/features/locality/domain/entity/locality.dart';
import 'package:travel_application/theme/colors_collection.dart';

class FilterModalBottomSheet extends StatefulWidget {
  final FilterService filterService;

  const FilterModalBottomSheet({Key? key, required this.filterService})
      : super(key: key);

  @override
  State<FilterModalBottomSheet> createState() => _FilterModalBottomSheetState();
}

class _FilterModalBottomSheetState extends State<FilterModalBottomSheet> {
  late List<ValueNotifier<bool>> isCheckedList;
  List<LocalityList> selectedLocalities = [];

  @override
  void initState() {
    super.initState();
    isCheckedList = List.generate(
      LocalityList.values.length,
      (index) => ValueNotifier(false),
    );
  }

  BoxDecoration get _modalDecoration => const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        color: ColorsCollection.surfaceContainerLow,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _modalHeaderBuilder(context),
          const SizedBox(height: 16),
          _addingCityBuilder(context),
          const SizedBox(height: 24),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _modalHeaderBuilder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).filter,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            S.of(context).apply,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: ColorsCollection.primary,
                ),
          ),
        ),
      ],
    );
  }

  Widget _addingCityBuilder(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            S.of(context).city,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: selectedLocalities.map((locality) {
              return InputChip(
                label: Text(locality.name(context),
                    style: Theme.of(context).textTheme.labelLarge),
                deleteIconColor: Colors.black,
                onDeleted: () {
                  setState(() {
                    selectedLocalities.remove(locality);
                  });
                },
              );
            }).toList(),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return ListView.builder(
                    itemCount: LocalityList.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      final locality = LocalityList.values[index];
                      return ListTile(
                        leading: Checkbox(
                          value: selectedLocalities.contains(locality),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value ?? false) {
                                selectedLocalities.add(locality);
                              } else {
                                selectedLocalities.remove(locality);
                              }
                            });
                          },
                        ),
                        title: Text(locality.name(context)),
                        onTap: () {
                          setState(() {
                            if (selectedLocalities.contains(locality)) {
                              selectedLocalities.remove(locality);
                            } else {
                              selectedLocalities.add(locality);
                            }
                          });
                        },
                      );
                    },
                  );
                },
              );
            },
            child: Text(
              S.of(context).addCity,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorsCollection.primary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
