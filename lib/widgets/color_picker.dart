import 'package:eventdark/models/event_color.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final EventColor color;
  final Function onChanged;

  ColorPicker({
    Key key,
    @required this.color,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  bool pressAttention = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => pressAttention = !pressAttention);
      },
      // child: Radio(
      //   value: widget.color,
      //   groupValue: widget.groupValue,
      //   onChanged: widget.onChanged(widget.color),
      //   activeColor: pressAttention ? Colors.black87: widget.color.toMaterialColor(),
     // ),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            color: pressAttention ? Colors.black87: widget.color.toMaterialColor(),
            width: 4.0,
          ),
          color: widget.color.toMaterialColor(),
        ),
      ),
    );
  }
}
