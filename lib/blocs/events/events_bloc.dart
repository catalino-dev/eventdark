import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eventdark/blocs/events/events.dart';
import 'package:eventdark/repositories/repositories.dart';
import 'package:meta/meta.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventsRepository _eventsRepository;
  StreamSubscription _eventsSubscription;

  EventsBloc({@required EventsRepository eventsRepository})
      : assert(eventsRepository != null),
        _eventsRepository = eventsRepository,
        super(EventsLoading());

  @override
  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    if (event is LoadEvents) {
      yield* _mapLoadEventsToState();
    } else if (event is AddEvent) {
      yield* _mapAddEventToState(event);
    } else if (event is UpdateEvent) {
      yield* _mapUpdateEventToState(event);
    } else if (event is DeleteEvent) {
      yield* _mapDeleteEventToState(event);
    } else if (event is ExportToCsvTrigger) {
      yield* _mapCsvExportToState();
    } else if (event is EventsUpdated) {
      yield* _mapEventsUpdateToState(event);
    }
  }

  Stream<EventsState> _mapLoadEventsToState() async* {
    _eventsSubscription?.cancel();
    _eventsSubscription = _eventsRepository.events().listen(
          (events) => add(EventsUpdated(events)),
        );
  }

  Stream<EventsState> _mapAddEventToState(AddEvent event) async* {
    _eventsRepository.addNewEvent(event.event);
  }

  Stream<EventsState> _mapUpdateEventToState(UpdateEvent event) async* {
    _eventsRepository.updateEvent(event.updatedEvent);
  }

  Stream<EventsState> _mapDeleteEventToState(DeleteEvent event) async* {
    _eventsRepository.deleteEvent(event.event);
  }

  Stream<EventsState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is EventsLoaded) {
      final allComplete = currentState.events.every((event) => event.complete);
      final List<Event> updatedEvents = currentState.events
          .map((event) => event.copyWith(complete: !allComplete))
          .toList();
      updatedEvents.forEach((updatedEvent) {
        _eventsRepository.updateEvent(updatedEvent);
      });
    }
  }

  Stream<EventsState> _mapCsvExportToState() async* {
    final currentState = state;
    if (currentState is EventsLoaded) {
      final List<Event> completedEvents =
          currentState.events.where((event) => event.complete).toList();
      completedEvents.forEach((completedEvent) {
        _eventsRepository.deleteEvent(completedEvent);
      });
    }
  }

  Stream<EventsState> _mapEventsUpdateToState(EventsUpdated event) async* {
    yield EventsLoaded(event.events, DateTime.now());
  }

  @override
  Future<void> close() {
    _eventsSubscription?.cancel();
    return super.close();
  }
}
