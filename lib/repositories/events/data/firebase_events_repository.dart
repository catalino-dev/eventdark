import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventdark/repositories/events/data/entities/entities.dart';
import 'package:eventdark/repositories/repositories.dart';

class FirebaseEventsRepository implements EventsRepository {
  final eventCollection = FirebaseFirestore.instance.collection('events');

  @override
  Future<void> addNewEvent(Event event) {
    return eventCollection.add(event.toEntity().toDocument());
  }

  @override
  Future<void> deleteEvent(Event event) async {
    return eventCollection.doc(event.id).delete();
  }

  @override
  Stream<List<Event>> events() {
    return eventCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Event.fromEntity(EventEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateEvent(Event update) {
    return eventCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}
