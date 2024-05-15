import 'package:travel_application/features/locality/domain/entity/locality.dart';

abstract class FilterEvent {
  const FilterEvent();
}

class ToggleLocalityEvent extends FilterEvent {
  final LocalityList locality;

  ToggleLocalityEvent(this.locality);
}

class AddCityEvent extends FilterEvent {
  final List<String> selectedCities;

  AddCityEvent(this.selectedCities);
}
