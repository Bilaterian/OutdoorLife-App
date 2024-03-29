import 'package:activityforecast/components/edit_activity.dart';
import 'package:activityforecast/components/themes/themes.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:activityforecast/models/theme.dart';
import 'package:activityforecast/models/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/add_activity.dart';
import 'package:activityforecast/components/remove_activity.dart';
import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:provider/provider.dart';

import '../services/activities_database.dart';

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

  final IconData activityIcon;
  final Function setStateOfAcitivity;

  // final Color? iconColor = moreActivityColors['iconColor'];
  // final Color? cardColor = moreActivityColors['cardColor'];
  // final Color? activityTextColor = moreActivityColors['textColor'];
  // final Color? dragIconColor = moreActivityColors['dragIconColor'];
  // final Color? addIconColor = moreActivityColors['addIconColor'];
  // final Color? iconColor = firstTheme["primary"];
  // final Color? cardColor = firstTheme["tertiary"];
  // final Color? activityTextColor = firstTheme["primary"];
  // final Color? dragIconColor = firstTheme['primary'];
  // final Color? addIconColor = firstTheme['primary'];

  // final Color? iconColor = firstTheme["primary"];
  // final Color? cardColor = firstTheme["quaternary"];
  // final Color? activityTextColor = firstTheme["primary"];
  // final Color? dragIconColor = firstTheme["primary"];
  // final Color? addIconColor = firstTheme["primary"];

  late Color? iconColor;
  late Color? cardColor;
  late Color? activityTextColor;
  late Color? dragIconColor;
  late Color? addIconColor;

  @override
  State<MoreActivityCard> createState() => _MoreActivityCardState();
}

class _MoreActivityCardState extends State<MoreActivityCard> {
  late ColourScheme theme;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context).currentTheme;
    widget.iconColor = theme.quaternary;
    widget.cardColor = theme.secondary;
    widget.activityTextColor = theme.quaternary;
    widget.dragIconColor = theme.quaternary;
    widget.addIconColor = theme.quaternary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: widget.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              // moreActivities.removeAt(widget.index);
              Provider.of<ActivityProvider>(context, listen: false)
                  .removeMoreActivity(widget.index);
              ActivitiesDatabase.instance.delete2(widget.index);
              widget.setStateOfAcitivity();
            });
          },
          background: _deleteContainer(),
          child: ListTile(
            key: widget.key,
            title: Text(
              widget.activity,
              style: TextStyle(
                  color: widget.activityTextColor, fontWeight: FontWeight.bold),
            ),
            leading: _leadingIcons(),
            // !<!<!< conflict
            trailing: _tralingIcon(),
            // trailing: ReorderableDragStartListener(
            //   index: widget.index,
            //   child: Icon(Icons.drag_handle, color: widget.dragIconColor),
            // ),
          ),
        ),
      ),
    );
  }

  Widget _tralingIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        EditActivity(
            activityToEdit: widget.index,
            textColor: widget.activityTextColor,
            whichActivityList: ActivityList.more),
        ReorderableDragStartListener(
          index: widget.index,
          child: Icon(Icons.drag_handle, color: widget.dragIconColor),
        ),
      ],
    );
  }

  Widget _deleteContainer() {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      alignment: Alignment.centerRight,
      color: Colors.red,
      child: const Text(
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
