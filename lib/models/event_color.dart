import 'package:flutter/material.dart';

enum EventColor { blue, green, sky, sage, lavender, pink }

extension ColorConverter on EventColor {
  MaterialColor toMaterialColor() {
    switch(this) {
      case EventColor.green:
        return Colors.green;
      case EventColor.pink:
        return Colors.pink;
      case EventColor.sky:
        return Colors.cyan;
      case EventColor.sage:
        return Colors.lightGreen;
      case EventColor.lavender:
        return Colors.deepPurple;
      default:
        return Colors.blue;
    }
  }
}

extension StringToEventColorConverter on String {

  EventColor toEventColor() {
    switch(this) {
      case 'green':
        return EventColor.green;
      case 'pink':
        return EventColor.pink;
      case 'sky':
        return EventColor.sky;
      case 'sage':
        return EventColor.sage;
      case 'lavender':
        return EventColor.lavender;
      default:
        return EventColor.blue;
    }
  }
}
