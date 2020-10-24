import 'package:eventdark/repositories/repositories.dart';
import 'package:eventdark/utils/datetime_extension.dart';
import 'package:eventdark/models/event_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EventItem extends StatelessWidget {
  final Function onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Event event;

  EventItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.03),
                offset: Offset(0,9),
                blurRadius: 20,
                spreadRadius: 1
            )]
        ),
        child: GestureDetector(
          onTap: () => onTap(),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: event.color.toMaterialColor(),
                        width: 4)
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(event.name, style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),),
                  Text(event.timeFrom.toDisplayString(), style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18
                  ),)
                ],
              ),
              Expanded(child: Container()),
              Container(
                height: 50,
                width: 5,
                color: event.color.toMaterialColor(),
              )
            ],
          ),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Edit",
          color: Colors.white,
          icon: Icons.edit,
          onTap: (){},
        ),
        IconSlideAction(
          caption: "Delete",
          color: event.color.toMaterialColor(),
          icon: Icons.edit,
          onTap: () => onDismissed(),
        )
      ],
    );
    // return Dismissible(
    //   key: Key('__event_item_${event.id}'),
    //   onDismissed: onDismissed,
    //   child: ListTile(
    //     onTap: onTap,
    //     leading: Checkbox(
    //       value: event.complete,
    //       onChanged: onCheckboxChanged,
    //     ),
    //     title: Hero(
    //       tag: '${event.id}__heroTag',
    //       child: Container(
    //         width: MediaQuery.of(context).size.width,
    //         child: Text(
    //           event.eventDate.toIso8601String(),
    //           style: Theme.of(context).textTheme.headline6,
    //         ),
    //       ),
    //     ),
    //     subtitle: event.name.isNotEmpty
    //         ? Text(
    //             event.name,
    //             maxLines: 1,
    //             overflow: TextOverflow.ellipsis,
    //             style: Theme.of(context).textTheme.subtitle1,
    //           )
    //         : null,
    //   ),
    // );
  }
}
