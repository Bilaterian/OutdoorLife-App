import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:activityforecast/HomePage.dart';
import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/current_activity_card.dart';
import 'package:activityforecast/components/more_activity_card.dart';
import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:activityforecast/view/pages/create_new_activity_page.dart';

class MainActivitiesPage extends StatefulWidget {
  MainActivitiesPage({Key? key, required this.title}) : super(key: key);

  final String title;
  // final Color backgroundColor = const Color(0xff041b5c);

  // final Color backgroundColor = const Color(0xff031342);
  // // final Color backgroundColor = const Color(0xff4a47a1);
  // final Color textColor = Colors.white;

  // // final Color appBarColor = const Color(0xff02424d);
  // final Color appBarColor = const Color(0xfff5ae16);
  final Color? backgroundColor = manageActivityColors['bgColor'];
  final Color? textColor = manageActivityColors['headerColor'];
  final Color? appBarColor = manageActivityColors['appBarColor'];
  final Color? appBarTextColor = manageActivityColors['appBarTextColor'];
  final Color? appBarIconColor = manageActivityColors['appBarIconColor'];
  final Color? floatingButtonColor =
      manageActivityColors['floatingButtonColor'];

  @override
  State<MainActivitiesPage> createState() => _MainActivitiesPageState();
}

class _MainActivitiesPageState extends State<MainActivitiesPage> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title,
                    style: TextStyle(color: widget.appBarTextColor)),
                backgroundColor: widget.appBarColor,
                actions: [
                  IconButton(
                      onPressed: () {
<<<<<<< Updated upstream
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
=======
                        //Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyApp()));
>>>>>>> Stashed changes
                      },
                      icon: Icon(Icons.home, color: widget.appBarIconColor))
                ],
              ),
              floatingActionButton: _createNewActivity(),
              backgroundColor: widget.backgroundColor,
              body: ListView(
                shrinkWrap: true,
                children: [
                  _activitiesHeader(currentActivities, "MY ACTIVITIES"),
                  Theme(
                      data: ThemeData(canvasColor: Colors.transparent),
                      child: _reorderableCurrentActivitiesView()),
                  _activitiesHeader(moreActivities, "MORE ACTIVITIES"),
                  Theme(
                      data: ThemeData(canvasColor: Colors.transparent),
                      child: _reorderableMoreActivitiesView()),
                  // ..._moreActivities()
                ],
              ));
        });
  }

// Floating Action Button
// When pushed, it should navigate to the create activity page
  Builder _createNewActivity() {
    return Builder(builder: (context) {
      return FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => Page()));
          //Navigator.of(context).pushNamed("/CreateNewActivity");
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateNewActivityPage()));
        },
        backgroundColor: widget.floatingButtonColor,
        child: const Icon(Icons.add_outlined, color: Colors.black),
      );
    });
  }

// Reorder List View to show "Current (My) Activities"
  ReorderableListView _reorderableCurrentActivitiesView() {
    return ReorderableListView(
        buildDefaultDragHandles: false,
        shrinkWrap: true,
        children: [..._currentActivities()],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var item = currentActivities.removeAt(oldIndex);
            currentActivities.insert(newIndex, item);
          });
        });
  }

// Reorder List View for to show "More Activities"
  ReorderableListView _reorderableMoreActivitiesView() {
    return ReorderableListView(
        physics: const ClampingScrollPhysics(),
        buildDefaultDragHandles: false,
        shrinkWrap: true,
        children: [..._moreActivities()],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var item = moreActivities.removeAt(oldIndex);
            moreActivities.insert(newIndex, item);
          });
        });
  }

// return a List of "More Activity" Cards
  List<Widget> _moreActivities() {
    List<Widget> activities = [];
    // activities.add(_header("MORE ACTIVITIES"));
    for (int index = 0; index < moreActivities.length; index++) {
      var newActivity = moreActivities[index];
      activities.add(MoreActivityCard(
        setStateOfAcitivity: refresh,
        activityIcon: newActivity["icon"],
        activity: newActivity["activity"],
        index: index,
        key: ValueKey(index),
      ));
    }
    return activities;
  }

// return a List of "Current (My) Activity" Cards
  List<Widget> _currentActivities() {
    List<Widget> activities = [];
    //
    for (int index = 0; index < currentActivities.length; index++) {
      var activity = currentActivities[index];
      activities.add(CurrentActivityCard(
        setStateOfAcitivity: refresh,
        activityIcon: activity["icon"],
        activity: activity["activity"],
        index: index,
        key: ValueKey(index),
      ));
    }
    return activities;
  }

  Widget _activitiesHeader(List activities, String header) {
    if (activities.isNotEmpty) {
      return _header(header);
    }
    return _header("");
  }

  Widget _header(String title) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Text(
          title,
          style: TextStyle(color: widget.textColor),
        ));
  }
}
