import 'package:equatable/equatable.dart';
import 'package:eventdark/models/event_grouping.dart';
import 'package:eventdark/models/models.dart';
import 'package:eventdark/repositories/events/data/models/models.dart';

abstract class FilteredEventsEvent extends Equatable {
  const FilteredEventsEvent();
}

class UpdateSelectedDateFilter extends FilteredEventsEvent {
  final VisibilityFilter filter;
  final DateTime dateSelected;
  final EventGroupBy groupBy;

  const UpdateSelectedDateFilter(this.filter, this.dateSelected, this.groupBy);

  @override
  List<Object> get props => [filter, dateSelected, groupBy];

  @override
  String toString() => 'UpdateSelectedDateFilter { filter: $filter, dateSelected: $dateSelected, groupBy: $groupBy }';
}

class UpdateEvents extends FilteredEventsEvent {
  final List<Event> events;
  final DateTime dateSelected;

  const UpdateEvents(this.events, this.dateSelected);

  @override
  List<Object> get props => [events, dateSelected];

  @override
  String toString() => 'UpdateEvents { events: $events, dateSelected: $dateSelected }';
}
