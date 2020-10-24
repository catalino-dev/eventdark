import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eventdark/utils/datetime_extension.dart';
import 'package:eventdark/blocs/blocs.dart';
import 'package:eventdark/blocs/events/events.dart';
import 'package:eventdark/blocs/filtered_events/filtered_events.dart';
import 'package:eventdark/models/event_grouping.dart';
import 'package:eventdark/models/models.dart';
import 'package:eventdark/repositories/events/data/models/models.dart';
import 'package:meta/meta.dart';

class FilteredEventsBloc extends Bloc<FilteredEventsEvent, FilteredEventsState> {
  final EventsBloc eventsBloc;

  DateTime dateSelected;
  StreamSubscription _eventsSubscription;

  FilteredEventsBloc({
    @required this.eventsBloc,
    this.dateSelected
  }): super(eventsBloc.state is EventsLoaded
          ? FilteredEventsLoaded(
              (eventsBloc.state as EventsLoaded).events,
              dateSelected ?? DateTime.now(),
              VisibilityFilter.all,
            )
          : FilteredEventsLoading()) {
    _eventsSubscription = eventsBloc.listen((state) {
      if (state is EventsLoaded) {
        add(UpdateEvents((eventsBloc.state as EventsLoaded).events, dateSelected ?? DateTime.now()));
      }
    });
  }

  @override
  Stream<FilteredEventsState> mapEventToState(FilteredEventsEvent event) async* {
    if (event is UpdateSelectedDateFilter) {
      yield* _mapUpdateSelectedDateFilterToState(event);
    } else if (event is UpdateEvents) {
      yield* _mapEventsUpdatedToState(event);
    }
  }

  Stream<FilteredEventsState> _mapUpdateSelectedDateFilterToState(UpdateSelectedDateFilter event) async* {
    final currentState = eventsBloc.state;
    if (currentState is EventsLoaded) {
      yield FilteredEventsLoaded(
        _mapEventsToFilteredEventsWithGrouping(currentState.events, event.filter, event.dateSelected, event.groupBy),
        event.dateSelected,
        event.filter,
      );
    }
  }

  Stream<FilteredEventsState> _mapEventsUpdatedToState(UpdateEvents event) async* {
    final visibilityFilter = state is FilteredEventsLoaded
        ? (state as FilteredEventsLoaded).activeFilter
        : VisibilityFilter.all;
    List<Event> events = (eventsBloc.state as EventsLoaded).events;

    yield FilteredEventsLoaded(
      _mapEventsToFilteredEvents(events, visibilityFilter),
      event.dateSelected,
      visibilityFilter,
    );
  }

  List<Event> _mapEventsToFilteredEvents(
      List<Event> events, VisibilityFilter filter) {
    return events.where((event) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !event.complete;
      } else {
        return event.complete;
      }
    }).toList();
  }

  List<Event> _mapEventsToFilteredEventsWithGrouping(List<Event> events,
      VisibilityFilter filter, DateTime dateSelected, EventGroupBy groupBy) {
    return events.where((event) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !event.complete;
      } else {
        return event.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _eventsSubscription?.cancel();
    return super.close();
  }
}
