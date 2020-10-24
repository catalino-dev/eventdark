import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  String toDisplayString() {
    DateFormat dateFormat = DateFormat("MMM dd, yyyy");
    return dateFormat.format(this);
  }
}

extension TimeOfDayCompare on TimeOfDay {
  String toDisplayString() {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, this.hour, this.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }
}
