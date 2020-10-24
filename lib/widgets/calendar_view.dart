import "package:collection/collection.dart";
import 'package:eventdark/blocs/blocs.dart';
import 'package:eventdark/models/event_grouping.dart';
import 'package:eventdark/models/models.dart';
import 'package:eventdark/repositories/events/data/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {

  CalendarView({Key key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    this._calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    this._calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredEventsBloc, FilteredEventsState>(
        builder: (context, state) {
          if (state is FilteredEventsLoaded) {
            return TableCalendar(
              calendarController: _calendarController,
              initialCalendarFormat: CalendarFormat.month,
              formatAnimation: FormatAnimation.slide,
              events: _getEventsMap(state.filteredEvents),
              headerStyle: _buildHeaderStyle(),
              weekendDays: [DateTime.sunday],
              onDaySelected: _onDaySelected,
            );
          } else {
            return Container();
          }
        },
    );
  }

  Map<DateTime, List> _getEventsMap(List<Event> events) {
    return groupBy(events, (event) => event.eventDate);
  }

  HeaderStyle _buildHeaderStyle() {
    return HeaderStyle(
      centerHeaderTitle: true,
      formatButtonVisible: false,
    );
  }

  void _onDaySelected(DateTime dateSelected, List calendarEvents, _) {
    BlocProvider.of<FilteredEventsBloc>(context)
        .add(UpdateSelectedDateFilter(VisibilityFilter.all, dateSelected, EventGroupBy.selected));
  }
}
