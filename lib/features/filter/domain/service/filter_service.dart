import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_application/features/filter/domain/service/filter_event.dart';
import 'package:travel_application/features/filter/domain/service/filter_state.dart';
import 'package:travel_application/features/locality/domain/entity/locality.dart';

class FilterService extends Bloc<FilterEvent, FilterState> {
  FilterService(FilterState initialState) : super(initialState) {
    on<ToggleLocalityEvent>(_onToggleLocalityEvent);
  }

  List<LocalityList> selectedLocalities = [];

  Future<void> _onToggleLocalityEvent(
    ToggleLocalityEvent event,
    Emitter<FilterState> emit,
  ) async {
    if (selectedLocalities.contains(event.locality)) {
      selectedLocalities.remove(event.locality);
    } else {
      selectedLocalities.add(event.locality);
    }

    emit(FilterState(selectedLocalities: List.of(selectedLocalities)));
  }
}
