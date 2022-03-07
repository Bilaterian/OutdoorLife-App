import 'package:flutter/material.dart';
import 'package:milestone_2/components/activities.dart';
import 'package:milestone_2/pages/manage_activities.dart';

class AddActivity extends StatefulWidget {
  const AddActivity(
      {Key? key,
      required this.activityToAdd,
      required this.setStateOfAcitivity,
      required this.iconColor})
      : super(key: key);

  final IconData addIcon = Icons.add_circle_rounded;
  // final IconData addIcon = Icons.add_circle_outline;
  // final IconData addIcon = Icons.add_outlined;
  final Function setStateOfAcitivity;

  final int activityToAdd;
  final Color? iconColor;
  // final Color iconColor = const Color(0xff04b091);

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          currentActivities.add(moreActivities[widget.activityToAdd]);
          moreActivities.remove(moreActivities[widget.activityToAdd]);
          widget.setStateOfAcitivity();
        },
        icon: Icon(
          widget.addIcon,
          color: widget.iconColor,
        ));
  }
}
