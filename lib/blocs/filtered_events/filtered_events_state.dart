import 'package:equatable/equatable.dart';
import 'package:eventdark/models/models.dart';
import 'package:eventdark/repositories/events/data/models/models.dart';

abstract class FilteredEventsState extends Equatable {
  const FilteredEventsState();

  @override
  List<Object> get props => [];
}

class FilteredEventsLoading extends FilteredEventsState {}

class FilteredEventsLoaded extends FilteredEventsState {
  final List<Event> filteredEvents;
  final DateTime dateSelected;
  final VisibilityFilter activeFilter;

  const FilteredEventsLoaded(
    this.filteredEvents,
    this.dateSelected,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredEvents, dateSelected, activeFilter];

  @override
  String toString() {
    return 'FilteredEventsLoaded { filteredEvents: $filteredEvents, dateSelected: $dateSelected, activeFilter: $activeFilter }';
  }
}
