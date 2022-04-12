import 'package:activityforecast/components/themes/themes.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:activityforecast/models/theme.dart';
import 'package:activityforecast/models/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/remove_activity.dart';
import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:provider/provider.dart';

import 'edit_activity.dart';

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
  // final Color? iconColor = currentActivityColors['iconColor'];
  // final Color? cardColor = currentActivityColors['cardColor'];
  // final Color? activityTextColor = currentActivityColors['textColor'];
  // final Color? dragIconColor = currentActivityColors['dragIconColor'];
  // final Color? removeIconColor = currentActivityColors['removeIconColor'];
  // final Color? iconColor = firstTheme["tertiary"];
  // final Color? cardColor = firstTheme["quinary"];
  // final Color? activityTextColor = firstTheme["tertiary"];
  // final Color? dragIconColor = firstTheme["tertiary"];
  // final Color? removeIconColor = firstTheme["tertiary"];
  // final Color? iconColor = firstTheme["primary"];
  // final Color? cardColor = firstTheme["tertiary"];
  // final Color? activityTextColor = firstTheme["primary"];
  // final Color? dragIconColor = firstTheme['primary'];
  // final Color? removeIconColor = firstTheme['primary'];

  // final Color? iconColor = firstTheme["quaternary"];
  // final Color? cardColor = firstTheme["tertiary"];
  // final Color? activityTextColor = firstTheme["quaternary"];
  // final Color? dragIconColor = firstTheme['quaternary'];
  // final Color? removeIconColor = firstTheme['quaternary'];

  late Color? iconColor;
  late Color? cardColor;
  late Color? activityTextColor;
  late Color? dragIconColor;
  late Color? removeIconColor;
  State<CurrentActivityCard> createState() => _CurrentActivityCardState();
}

class _CurrentActivityCardState extends State<CurrentActivityCard> {
  late ColourScheme theme;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context).currentTheme;
    widget.iconColor = theme.secondary;
    widget.cardColor = theme.quinary;
    widget.activityTextColor = theme.secondary;
    widget.dragIconColor = theme.secondary;
    widget.removeIconColor = theme.secondary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: widget.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          // !<!<!< conflict
            onTap: () {},
            key: widget.key,
            title: Text(widget.activity,
                style: TextStyle(
                    color: widget.activityTextColor,
                    fontWeight: FontWeight.bold)),
            leading: _leadingIcons(),
            trailing: _tralingIcon()
        ),
            /*
          onTap: () {},
          key: widget.key,
          title: Text(widget.activity,
              style: TextStyle(
                  color: widget.activityTextColor,
                  fontWeight: FontWeight.bold)),
          leading: _leadingIcons(),
          // trailing: ReorderableDragStartListener(
          //   index: widget.index,
          //   child: Icon(Icons.drag_handle, color: widget.dragIconColor),
          // ),
          */
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
            whichActivityList: ActivityList.current),
        ReorderableDragStartListener(
          index: widget.index,
          child: Icon(Icons.drag_handle, color: widget.dragIconColor),
        ),
      ],
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
