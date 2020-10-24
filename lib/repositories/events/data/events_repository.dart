import 'dart:async';

import 'package:eventdark/repositories/events/data/models/event.dart';

abstract class EventsRepository {
  Future<void> addNewEvent(Event event);

  Future<void> deleteEvent(Event event);

  Stream<List<Event>> events();

  Future<void> updateEvent(Event event);

  Future<void> exportToCsv();
}
