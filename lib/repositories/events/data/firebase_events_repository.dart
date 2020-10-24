import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:eventdark/repositories/events/data/entities/entities.dart';
import 'package:eventdark/repositories/repositories.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseEventsRepository implements EventsRepository {
  final eventCollection = FirebaseFirestore.instance.collection('events');
  String filePath;

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

  @override
  Future<void> exportToCsv() async {
    print('-----EXPORTING------');
    List<List<Event>> eventStream = await eventCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Event.fromEntity(EventEntity.fromSnapshot(doc)))
          .toList();
    }).toList();

    File file = await _localFile;
    String csv = const ListToCsvConverter().convert(eventStream);
    print('-----------------: $csv');
    file.writeAsString(csv);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    filePath = '$path/data.csv';
    return File('$path/data.csv').create();
  }
}
