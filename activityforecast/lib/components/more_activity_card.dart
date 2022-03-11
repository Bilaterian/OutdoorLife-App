import 'package:flutter/material.dart';
import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/add_activity.dart';
import 'package:activityforecast/components/remove_activity.dart';
import 'package:activityforecast/components/themes/manage_activities_colors.dart';

class MoreActivityCard extends StatefulWidget {
  MoreActivityCard(
      {Key? key,
      required this.activityIcon,
      required this.activity,
      required this.index,
      required this.setStateOfAcitivity})
      : super(key: key);

  final String activity;
  final int index;
  // final Color cardColor = manageActivityColors.;
  // final Color iconColor = const Color(0xff10acc7);
  // final Color iconColor = const Color(0xff4ad7d9);
  // // final Color iconColor = const Color(0xfff09b13);
  // // final Color iconColor = const Color(0xfff5ae16);
  // final Color activityTextColor = Colors.white;
  final IconData activityIcon;
  final Function setStateOfAcitivity;

  final Color? iconColor = moreActivityColors['iconColor'];
  final Color? cardColor = moreActivityColors['cardColor'];
  final Color? activityTextColor = moreActivityColors['textColor'];
  final Color? dragIconColor = moreActivityColors['dragIconColor'];
  final Color? addIconColor = moreActivityColors['addIconColor'];

  @override
  State<MoreActivityCard> createState() => _MoreActivityCardState();
}

class _MoreActivityCardState extends State<MoreActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        /*087082*/
        // color: Color(0xff18337a),
        // color: Color(0xff54519e),
        color: widget.cardColor,
        // color: Color(0xff633587),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              moreActivities.removeAt(widget.index);
              widget.setStateOfAcitivity();
            });
          },
          background: _deleteContainer(),
          child: ListTile(
            key: widget.key,
            title: Text(
              widget.activity,
              style: TextStyle(color: widget.activityTextColor),
            ),
            leading: _leadingIcons(),
            trailing: ReorderableDragStartListener(
              index: widget.index,
              child: Icon(Icons.drag_handle, color: widget.dragIconColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _deleteContainer() {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      alignment: Alignment.centerRight,
      color: Colors.red,
      child: Text(
        'Delete',
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _leadingIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddActivity(
          activityToAdd: widget.index,
          setStateOfAcitivity: widget.setStateOfAcitivity,
          iconColor: widget.addIconColor,
        ),
        Icon(
          widget.activityIcon,
          color: widget.iconColor,
        ),
      ],
    );
  }
}
