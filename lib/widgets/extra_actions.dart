import 'package:eventdark/blocs/blocs.dart';
import 'package:eventdark/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is EventsLoaded) {
          return PopupMenuButton<ExtraAction>(
            onSelected: (action) {
              switch (action) {
                case ExtraAction.exportToCsv:
                  BlocProvider.of<EventsBloc>(context).add(ExportToCsvTrigger());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                value: ExtraAction.exportToCsv,
                child: Text('Export to CSV'),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
