import 'package:eventdark/models/event_color.dart';
import 'package:eventdark/utils/time_of_day.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class Event {
  final bool complete;
  final String id;
  final String name;
  final DateTime eventDate;
  final TimeOfDay timeFrom;
  final TimeOfDay timeTo;
  final EventColor color;

  Event(this.eventDate, {this.complete = false, String name = '', String id, TimeOfDay timeFrom, TimeOfDay timeTo, EventColor color})
      : this.name = name ?? '',
        this.timeFrom = timeFrom ?? TimeOfDay.now(),
        this.timeTo = timeTo ?? TimeOfDay.now(),
        this.color = color ?? EventColor.blue,
        this.id = id;

  Event copyWith({bool complete, String id, String name, DateTime eventDate, TimeOfDay timeFrom, TimeOfDay timeTo, EventColor color}) {
    return Event(
      eventDate ?? this.eventDate,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      color: color ?? this.color,
      name: name ?? this.name,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^ eventDate.hashCode ^ name.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          eventDate == other.eventDate &&
          timeFrom == other.timeFrom &&
          timeTo == other.timeTo &&
          color == other.color &&
          name == other.name &&
          id == other.id;

  @override
  String toString() {
    return 'Event{complete: $complete, eventDate: $eventDate, timeFrom: $timeFrom, timeTo: $timeTo, color: $color, name: $name, id: $id}';
  }

  EventEntity toEntity() {
    TimeOfDayIntConverter timeOfDayIntConverter = TimeOfDayIntConverter();
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    int timeFromConverted = timeOfDayIntConverter.convertFromTimeOfDay(timeFrom);
    int timeToConverted = timeOfDayIntConverter.convertFromTimeOfDay(timeTo);
    return EventEntity(id, name, dateFormat.format(eventDate), complete, timeFromConverted, timeToConverted, color.toString());
  }

  static Event fromEntity(EventEntity entity) {
    TimeOfDayIntConverter timeOfDayIntConverter = TimeOfDayIntConverter();
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    DateTime eventDate = dateFormat.parse(entity.eventDate);
    return Event(
      eventDate,
      complete: entity.complete ?? false,
      name: entity.name,
      timeFrom: timeOfDayIntConverter.convertFromInt(entity.timeFrom),
      timeTo: timeOfDayIntConverter.convertFromInt(entity.timeTo),
      color: entity.color.toEventColor(),
      id: entity.id,
    );
  }

  static Event fromObject(dynamic entity) {
    return Event(
      entity.eventDate,
      complete: entity.complete ?? false,
      name: entity.name,
      timeFrom: entity.timeFrom,
      timeTo: entity.timeTo,
      color: entity.color,
      id: entity.id,
    );
  }
}
