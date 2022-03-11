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
  // // final Color iconColor = const Color(0xffffb014);
  // // final Color iconColor = const Color(0xffffb014);

  // final Color iconColor = const Color(0xff3a0266);
  // // final Color iconColor = const Color(0xfff5b536);
  // // final Color iconColor = const Color(0xff4ad7d9);color: Color(0xfff5b536),
  // // final Color iconColor = const Color(0xff204199);
  final IconData activityIcon;
  final Function setStateOfAcitivity;
  // // final Color activityTextColor = Colors.white;
  // final Color activityTextColor = Colors.black;
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
    var activity = currentActivities[widget.index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        // 0xff38838a
        //59578a
        // color: Color(0xff54519e),
        // color: Color(0xff38838a),
        // color: Color(0xff4a47a1),
        // color: Color(0xff885696),
        // color: Color(0xffe3a114).withOpacity(.8),
        // color: Color(0xfff5b536),
        // color: Color(0xff369a9c),
        // color: Color(0xff448385),
        // color: Color(0xff4c999c),
        // color: Color(0xff633587),
        // color: Color(0xff30a6ab),
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
