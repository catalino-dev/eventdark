import 'package:eventdark/models/event_color.dart';
import 'package:eventdark/widgets/color_picker.dart';
import 'package:flutter/material.dart';

class ColorChooser extends StatefulWidget {
  final List<EventColor> eventColors;
  final Function onColorTap;

  ColorChooser({
    Key key,
    @required this.eventColors,
    @required this.onColorTap,
  }) : super(key: key);

  @override
  _ColorChooserState createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
          childAspectRatio: 1.75,
        ),
        itemCount: widget.eventColors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            splashColor: Colors.blue,
            onTap: () {
              setState(() {
                widget.onColorTap(widget.eventColors[index]);
              });
            },
            child: ColorPicker(color: widget.eventColors[index], onChanged: () {}),
          );
        },
      ),
    );
  }
}
