import 'package:eventdark/models/event_color.dart';
import 'package:eventdark/repositories/repositories.dart';
import 'package:eventdark/utils/datetime_extension.dart';
import 'package:eventdark/widgets/color_chooser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef OnSaveCallback = Function(String id, DateTime eventDate, String name, EventColor color);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Event _event;
  String _name;
  EventColor _color;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    _event = ModalRoute.of(context).settings.arguments;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Event' : 'Add Event',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                _event.eventDate.toDisplayString(),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                initialValue: isEditing ? _event.name : '',
                autofocus: !isEditing,
                style: textTheme.headline6,
                decoration: InputDecoration(
                  hintText: 'Add event name',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) {
                  return _name = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
                child: Text("Choose a color:",
                  style: TextStyle(
                    fontSize: 18
                  )
                ),
              ),
              ColorChooser(eventColors: [
                EventColor.blue, EventColor.green, EventColor.sky,
                EventColor.sage, EventColor.pink, EventColor.lavender
              ], onColorTap: (color) {
                setState(() {
                  _color = color;
                });
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 180.0,
        height: 50.0,
        child: FloatingActionButton.extended(
          tooltip: isEditing ? 'Update Event' : 'Add Event',
          icon: Icon(isEditing ? Icons.check : Icons.add),
          label: Text(isEditing ? 'Update Event' : 'Add Event'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.onSave(_event.id, _event.eventDate, _name, _color);
              Navigator.popAndPushNamed(context, '/', arguments: _event);
            }
          },
        ),
      ),
    );
  }
}
