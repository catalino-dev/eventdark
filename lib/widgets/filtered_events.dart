import 'package:eventdark/blocs/blocs.dart';
import 'package:eventdark/config/theme.dart';
import 'package:eventdark/models/event_grouping.dart';
import 'package:eventdark/repositories/events/data/models/event.dart';
import 'package:eventdark/utils/datetime_extension.dart';
import 'package:eventdark/widgets/filtered_events_list.dart';
import 'package:eventdark/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredEvents extends StatelessWidget {
  final EventGroupBy groupBy;

  FilteredEvents({Key key, @required this.groupBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredEventsBloc, FilteredEventsState>(
      builder: (context, state) {
        if (state is FilteredEventsLoading) {
          return LoadingIndicator();
        } else if (state is FilteredEventsLoaded) {
          return _buildFilteredEventsGroup(context, state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildFilteredEventsGroup(BuildContext context, FilteredEventsLoaded state) {
    Widget filteredListWidget;
    List<Event> events = state.filteredEvents;
    if (groupBy == EventGroupBy.selected) {
      events = events.where((event) => event.eventDate.isSameDate(state.dateSelected)).toList();
      filteredListWidget = FilteredEventsList(events: events);
    } else {
      filteredListWidget = FilteredEventsList(events: events);
    }
    return Stack(
      children: [
        filteredListWidget,
        _buildNewEventButton(context, state.dateSelected)
      ],
    );
  }

  Widget _buildNewEventButton(BuildContext context, DateTime dateSelected) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: FloatingActionButton(
          backgroundColor: primaryAccent(),
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, '/addEvent', arguments: Event(dateSelected)),
        ),
      ),
    );
  }
}
