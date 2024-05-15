import 'package:flutter/material.dart';

BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      border: Border.all(
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      borderRadius: BorderRadius.circular(12),
    );
