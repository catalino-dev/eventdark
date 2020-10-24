import 'package:eventdark/repositories/repositories.dart';
import 'package:flutter/material.dart';

class DeleteEventSnackBar extends SnackBar {
  DeleteEventSnackBar({
    Key key,
    @required Event event,
    @required VoidCallback onUndo,
  }) : super(
        key: key,
        content: Text(
          'Deleted ${event.eventDate}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: onUndo,
        ),
      );
}
