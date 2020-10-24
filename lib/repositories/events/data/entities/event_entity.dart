import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String id;
  final String name;
  final String eventDate;
  final bool complete;
  final int timeFrom;
  final int timeTo;
  final String color;

  const EventEntity(this.id, this.name, this.eventDate, this.complete, this.timeFrom, this.timeTo, this.color);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "eventDate": eventDate,
      "complete": complete,
      "timeFrom": timeFrom,
      "timeTo": timeTo,
      "color": color,
    };
  }

  @override
  List<Object> get props => [id, name, eventDate, complete, timeFrom, timeTo, color];

  @override
  String toString() {
    return 'EventEntity { id: $id, name: $name, eventDate: $eventDate, complete: $complete, timeFrom: $timeFrom, timeTo: $timeTo, color: $color }';
  }

  static EventEntity fromJson(Map<String, Object> json) {
    return EventEntity(
      json["id"] as String,
      json["name"] as String,
      json["eventDate"] as String,
      json["complete"] as bool,
      json["timeTo"] as int,
      json["timeTo"] as int,
      json["color"] as String,
    );
  }

  static EventEntity fromSnapshot(DocumentSnapshot snap) {
    return EventEntity(
      snap.id,
      snap.data()['name'],
      snap.data()['eventDate'],
      snap.data()['complete'],
      snap.data()['timeFrom'],
      snap.data()['timeTo'],
      snap.data()['color'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "eventDate": eventDate,
      "complete": complete,
      "timeFrom": timeFrom,
      "timeTo": timeTo,
      "color": color,
    };
  }
}
