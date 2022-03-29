import 'package:flutter/material.dart';
import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/remove_activity.dart';
import 'package:activityforecast/components/themes/manage_activities_colors.dart';

class CurrentActivityCard extends StatefulWidget {
  CurrentActivityCard(
      {Key? key,
      required this.activityIcon,
      required this.activity,
      required this.index,
      required this.setStateOfAcitivity})
      : super(key: key);

  final String activity;
  final int index;
  final IconData activityIcon;
  final Function setStateOfAcitivity;
  final Color? iconColor = currentActivityColors['iconColor'];
  final Color? cardColor = currentActivityColors['cardColor'];
  final Color? activityTextColor = currentActivityColors['textColor'];
  final Color? dragIconColor = currentActivityColors['dragIconColor'];
  final Color? removeIconColor = currentActivityColors['removeIconColor'];

  @override
  State<CurrentActivityCard> createState() => _CurrentActivityCardState();
}

class _CurrentActivityCardState extends State<CurrentActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          onTap: () {},
          key: widget.key,
          title: Text(widget.activity,
              style: TextStyle(color: widget.activityTextColor)),
          leading: _leadingIcons(),
          trailing: ReorderableDragStartListener(
            index: widget.index,
            child: Icon(Icons.drag_handle, color: widget.dragIconColor),
          ),
        ),
      ),
    );
  }

  Widget _leadingIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RemoveActivity(
          activityToRemove: widget.index,
          setStateOfAcitivity: widget.setStateOfAcitivity,
          iconColor: widget.removeIconColor,
        ),
        Icon(
          widget.activityIcon,
          color: widget.iconColor,
        ),
      ],
    );
  }
}
