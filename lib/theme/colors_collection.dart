import 'package:flutter/material.dart';

abstract class ColorsCollection {
  static const primary = Color(0xFF25DF5A);
  static const onPrimary = Colors.white;
  static const primaryContainer = Color(0xFFFFD8EC);
  static const onPrimaryContainer = Color(0xFF073C14);
  static const secondary = Color(0xFF0D5822);
  static const onSecondary = Colors.white;
  static const error = Color(0xFFBA1A1A);
  static const onError = Colors.white;
  static const surface = Color(0xFFFFF8F9);
  static const onSurface = Color(0xFF211A1D);
  static const background = surface;
  static const onBackground = onSurface;
  static const button = Color(0xFFE3DDDF);
  static const outline = Color(0xFF81737A);

  static const onSurfaceVariant = Color(0xFF4F4449);

  static const surfaceContainerLow = Color(0xFFE4FFE5);

  static const surfaceContainer = Color(0xFFF9EAEF);

  static const outlineVariant = Color(0xFFD3C2C9);

  static const secondaryContainer = Color(0xFFFFD9E2);
  static const gradient1 = Color(0xFF25DF5A);
  static const gradient2 = Color(0xFF137B16);
}

abstract class ColorsCollectionDark {
  static const primary = Color(0xFF25DF5A);
  static const onPrimary = Color(0xFF076412);
  static const primaryContainer = Color(0xFF0C4517);
  static const onPrimaryContainer = Color(0xFF91E3A5);
  static const secondary = Color(0xFF0D5822);
  static const onSecondary = Colors.white;
  static const error = Color(0xFFBA1A1A);
  static const onError = Colors.white;
  static const surface = Color(0xFF181115);
  static const onSurface = Color(0xFFFFFFFF);
  static const background = surface;
  static const onBackground = onSurface;
  static const button = Color(0xFFE3DDDF);
  static const outline = Color(0xFF9C8D93);

  static const onSurfaceVariant = Color.fromARGB(255, 193, 230, 204);

  static const surfaceContainerLow = Color(0xFF211A1D);

  static const surfaceContainer = Color(0xFFF9EAEF);

  static const outlineVariant = Color(0xFF4F4449);

  static const secondaryContainer = Color(0xFFFFD9E2);
}
