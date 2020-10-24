import 'package:eventdark/blocs/blocs.dart';
import 'package:eventdark/repositories/events/data/models/models.dart';
import 'package:eventdark/screens/screens.dart';
import 'package:eventdark/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredEventsList extends StatelessWidget {

  const FilteredEventsList({
    Key key,
    @required this.events,
  }) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventItem(
          event: event,
          onDismissed: () {
            BlocProvider.of<EventsBloc>(context)
                .add(DeleteEvent(event));
            Scaffold.of(context).showSnackBar(DeleteEventSnackBar(
              event: event,
              onUndo: () =>
                  BlocProvider.of<EventsBloc>(context).add(AddEvent(event)),
            ));
          },
          onTap: () async {
            final removedTodo = await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return DetailsScreen(id: event.id);
              }),
            );
            if (removedTodo != null) {
              Scaffold.of(context).showSnackBar(
                DeleteEventSnackBar(
                  event: event,
                  onUndo: () => BlocProvider.of<EventsBloc>(context)
                      .add(AddEvent(event)),
                ),
              );
            }
          },
          onCheckboxChanged: (_) {
            BlocProvider.of<EventsBloc>(context).add(
              UpdateEvent(event.copyWith(complete: !event.complete)),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 8,
        color: Colors.blueGrey,
      ),
    );
  }
}
