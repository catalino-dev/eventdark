import 'package:eventdark/blocs/blocs.dart';
import 'package:eventdark/config/style.dart';
import 'package:eventdark/models/event_grouping.dart';
import 'package:eventdark/models/models.dart';
import 'package:eventdark/widgets/calendar_view.dart';
import 'package:eventdark/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffff8000),
            elevation: 0,
            title: Text("EventDark",
              style: appBarStyle(),
            ),
            actions: [
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.calendarView ?
            Column(
              children: [
                CalendarView(),
                Expanded(child: FilteredEvents(groupBy: EventGroupBy.selected)),
              ],
            ) :
            BlocProvider<FilteredEventsBloc>(
                create: (context) => FilteredEventsBloc(
                  eventsBloc: BlocProvider.of<EventsBloc>(context),
                ),
                child: FilteredEvents(groupBy: EventGroupBy.all)
            ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}
