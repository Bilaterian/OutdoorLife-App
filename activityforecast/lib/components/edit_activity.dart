import 'package:activityforecast/components/icons.dart';
import 'package:activityforecast/models/activity.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:activityforecast/view/pages/edit_activity_page.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/components/activities.dart';

import 'package:provider/provider.dart';

class EditActivity extends StatefulWidget {
  const EditActivity(
      {Key? key,
      required this.activityToEdit,
      required this.textColor,
      required this.whichActivityList})
      : super(key: key);

  final int activityToEdit;
  final Enum whichActivityList;
  final Color? textColor;

  @override
  State<EditActivity> createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          List<Activity> list = (widget.whichActivityList == ActivityList.more)
              ? Provider.of<ActivityProvider>(context, listen: false)
                  .moreActivities
              : Provider.of<ActivityProvider>(context, listen: false)
                  .currentActivities;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EditActivityPage(
                activityToEditIndex: widget.activityToEdit,
                whichActivityList: widget.whichActivityList,
                list: list);
          }));
          // Activity activity =
          //     Provider.of<ActivityProvider>(context, listen: false)
          //         .currentActivities[widget.activityToRemove];
          // Provider.of<ActivityProvider>(context, listen: false)
          //     .removeMyActivity(activity, widget.activityToRemove);
        },
        child: Text(
          "Edit",
          style: TextStyle(color: widget.textColor),
        ));
  }
}
