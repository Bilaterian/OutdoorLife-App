import 'package:flutter/material.dart';
import 'package:activityforecast/components/activities.dart';

class RemoveActivity extends StatefulWidget {
  const RemoveActivity(
      {Key? key,
      required this.activityToRemove,
      required this.setStateOfAcitivity,
      required this.iconColor})
      : super(key: key);

  final int activityToRemove;
  final IconData removeIcon = Icons.remove_circle_rounded;
  // final IconData removeIcon = Icons.remove_outlined;
  // final Color iconColor = const Color(0xfff5052d);
  final Color? iconColor;
  final Function setStateOfAcitivity;

  @override
  State<RemoveActivity> createState() => _RemoveActivityState();
}

class _RemoveActivityState extends State<RemoveActivity> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          moreActivities.add(currentActivities[widget.activityToRemove]);
          currentActivities.remove(currentActivities[widget.activityToRemove]);
          widget.setStateOfAcitivity();
        },
        icon: Icon(widget.removeIcon,
            // color: Colors.white.withOpacity(.7),
            color: widget.iconColor));
  }
}
