import 'package:travel_application/features/locality/domain/entity/locality.dart';

class FilterState {
  final List<LocalityList> selectedLocalities;

  FilterState({required this.selectedLocalities});
}
