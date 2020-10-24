import 'package:equatable/equatable.dart';
import 'package:eventdark/repositories/events/data/models/models.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Event> events;
  final DateTime dateSelected;

  const EventsLoaded(this.events, this.dateSelected);

  @override
  List<Object> get props => [events, dateSelected];

  @override
  String toString() => 'EventsLoaded { events: $events, dateSelected: $dateSelected }';
}

class EventsNotLoaded extends EventsState {}
