import 'dart:async';

import 'models/models.dart';

abstract class EventsRepository {
  Future<void> addNewEvent(Event todo);

  Future<void> deleteEvent(Event todo);

  Stream<List<Event>> events();

  Future<void> updateEvent(Event todo);
}
