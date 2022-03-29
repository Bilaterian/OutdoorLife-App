import 'package:activityforecast/models/activity.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/components/activities.dart';

import 'package:provider/provider.dart';

class RemoveActivity extends StatefulWidget {
  const RemoveActivity(
      {Key? key,
      required this.activityToRemove,
      required this.setStateOfAcitivity,
      required this.iconColor})
      : super(key: key);

  final int activityToRemove;
  final IconData removeIcon = Icons.remove_circle_rounded;
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
          //  add(currentActivities[widget.activityToRemove]);
          Activity activity =
              Provider.of<ActivityProvider>(context, listen: false)
                  .currentActivities[widget.activityToRemove];
          Provider.of<ActivityProvider>(context, listen: false)
              .removeMyActivity(activity, widget.activityToRemove);

          // currentActivities.remove(currentActivities[widget.activityToRemove]);
          widget.setStateOfAcitivity();
        },
        icon: Icon(widget.removeIcon, color: widget.iconColor));
  }
}
