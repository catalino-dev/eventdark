import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eventdark/blocs/tab/tab.dart';
import 'package:eventdark/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.calendarView);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
