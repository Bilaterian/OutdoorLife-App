import 'dart:developer';

import 'package:activityforecast/models/activity.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/pages/manage_activities.dart';
import 'package:activityforecast/services/activities_database.dart';
import 'package:provider/provider.dart';

class AddActivity extends StatefulWidget {
  const AddActivity(
      {Key? key,
      required this.activityToAdd,
      required this.setStateOfAcitivity,
      required this.iconColor})
      : super(key: key);

  final IconData addIcon = Icons.add_circle_rounded;

  final Function setStateOfAcitivity;

  final int activityToAdd;
  final Color? iconColor;

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          // currentActivities.add(moreActivities[widget.activityToAdd]);
          // moreActivities.remove(moreActivities[widget.activityToAdd]);
          Activity activity =
              Provider.of<ActivityProvider>(context, listen: false)
                  .moreActivities[widget.activityToAdd];
          Provider.of<ActivityProvider>(context, listen: false)
              .addMyActivity(activity, widget.activityToAdd);
          widget.setStateOfAcitivity();
          ActivitiesDatabase.instance.create(activity);
          ActivitiesDatabase.instance.delete2(widget.activityToAdd);
          log("INSERT ACTIVITY");
        },
        icon: Icon(
          widget.addIcon,
          color: widget.iconColor,
        ));
  }
}
