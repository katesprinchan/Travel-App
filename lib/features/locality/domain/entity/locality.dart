import 'package:flutter/material.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';

abstract class Locality {
  final String Function(BuildContext context) name;

  const Locality(this.name);
}

enum LocalityList implements Locality {
  rybnitsa(_rybnitsa),
  bender(_bender),
  dubossary(_dubossary),
  grigoriopol(_grigoriopol),
  kamenka(_kamenka),
  slobodzeya(_slobodzeya),
  dnestrovsk(_dnestrovsk),
  tiraspol(_tiraspol);

  const LocalityList(this.name);

  @override
  final String Function(BuildContext context) name;
}

String _tiraspol(BuildContext context) => S.of(context).tiraspol;

String _rybnitsa(BuildContext context) => S.of(context).rybnitsa;

String _bender(BuildContext context) => S.of(context).bender;

String _dubossary(BuildContext context) => S.of(context).dubossary;

String _grigoriopol(BuildContext context) => S.of(context).grigoriopol;

String _kamenka(BuildContext context) => S.of(context).kamenka;

String _slobodzeya(BuildContext context) => S.of(context).slobodzeya;

String _dnestrovsk(BuildContext context) => S.of(context).dnestrovsk;
