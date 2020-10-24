import 'package:bloc/bloc.dart';
import 'package:eventdark/blocs/blocs.dart';
import 'package:eventdark/repositories/repositories.dart';
import 'package:eventdark/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(EventDarkApp());
}

class EventDarkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsBloc>(
          create: (context) {
            return EventsBloc(
              eventsRepository: FirebaseEventsRepository(),
            )..add(LoadEvents());
          },
        )
      ],
      child: MaterialApp(
        title: 'EventDark',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) {
            Event event = ModalRoute.of(context).settings.arguments;
            return MultiBlocProvider(
              providers: [
                BlocProvider<TabBloc>(
                  create: (context) => TabBloc(),
                ),
                BlocProvider<FilteredEventsBloc>(
                  create: (context) => FilteredEventsBloc(
                    eventsBloc: BlocProvider.of<EventsBloc>(context),
                    dateSelected: event?.eventDate
                  ),
                ),
              ],
              child: HomeScreen(),
            );
          },
          '/addEvent': (context) {
            return AddEditScreen(
              onSave: (_, eventDate, name, color) {
                BlocProvider.of<EventsBloc>(context).add(
                  AddEvent(Event(eventDate, name: name, color: color)),
                );
              },
              isEditing: false,
            );
          },
          '/editEvent': (context) {
            return AddEditScreen(
              onSave: (id, eventDate, name, color) {
                BlocProvider.of<EventsBloc>(context).add(
                  UpdateEvent(Event(eventDate, name: name, color: color, id: id)),
                );
              },
              isEditing: true,
            );
          },
        },
      ),
    );
  }
}
