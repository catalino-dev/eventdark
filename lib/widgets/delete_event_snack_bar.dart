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
          'Deleted event ${event.name} successfully.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: onUndo,
        ),
      );
}
