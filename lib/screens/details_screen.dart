import 'package:eventdark/blocs/blocs.dart';
import 'package:eventdark/repositories/repositories.dart';
import 'package:eventdark/utils/datetime_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        final Event event = (state as EventsLoaded)
            .events
            .firstWhere((todo) => todo.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Event Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Event',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<EventsBloc>(context).add(DeleteEvent(event));
                  Navigator.popAndPushNamed(context, '/', arguments: event);
                },
              )
            ],
          ),
          body: event == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Checkbox(
                              value: event.complete,
                              onChanged: (_) {
                                BlocProvider.of<EventsBloc>(context).add(
                                  UpdateEvent(
                                    event.copyWith(complete: !event.complete),
                                  ),
                                );
                              }),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${event.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      event.eventDate.toDisplayString(),
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  event.name,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Edit Event',
            child: Icon(Icons.edit),
            onPressed: event == null ? null : () {
              print('Edit Event ------------- event: $event');
              return Navigator.pushNamed(context, '/editEvent', arguments: event);
            },
          ),
        );
      },
    );
  }
}
