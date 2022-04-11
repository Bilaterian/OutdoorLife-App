import 'dart:ui';

import 'package:activityforecast/models/activity.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:activityforecast/models/theme.dart';
import 'package:activityforecast/models/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/view/pages/home_page.dart';
import 'package:activityforecast/components/activities.dart';
import 'package:activityforecast/components/current_activity_card.dart';
import 'package:activityforecast/components/more_activity_card.dart';
import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:activityforecast/components/themes/themes.dart';
import 'package:activityforecast/view/pages/create_new_activity_page.dart';
import 'package:activityforecast/services/activities_database.dart';
import 'package:provider/provider.dart';
import 'package:activityforecast/models/activity.dart';

class MainActivitiesPage extends StatefulWidget {
  MainActivitiesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  // final Color? backgroundColor = manageActivityColors['bgColor'];
  // final Color? textColor = manageActivityColors['headerColor'];
  // final Color? appBarColor = manageActivityColors['appBarColor'];
  // final Color? appBarTextColor = manageActivityColors['appBarTextColor'];
  // final Color? appBarIconColor = manageActivityColors['appBarIconColor'];
  // final Color? floatingButtonColor =
  //     manageActivityColors['floatingButtonColor'];
  // final Color? backgroundColor = firstTheme["quaternary"];
  // final Color? textColor = firstTheme["primary"];
  // final Color? appBarColor = firstTheme["quinary"];
  // final Color? appBarTextColor = firstTheme["quaternary"];
  // final Color? appBarIconColor = firstTheme["quaternary"];
  // final Color? floatingButtonColor = firstTheme["quinary"];\

  // final Color? backgroundColor = firstTheme["quaternary"];
  // final Color? textColor = firstTheme["primary"];
  // final Color? appBarColor = firstTheme["primary"];
  // final Color? appBarTextColor = firstTheme["quaternary"];
  // final Color? appBarIconColor = firstTheme["quaternary"];
  // final Color? floatingButtonColor = firstTheme["primary"];

  late Color? backgroundColor;
  late Color? textColor;
  late Color? appBarColor;
  late Color? appBarTextColor;
  late Color? appBarIconColor;
  late Color? floatingButtonColor;

  @override
  State<MainActivitiesPage> createState() => _MainActivitiesPageState();
}

class _MainActivitiesPageState extends State<MainActivitiesPage> {
  // to allow dynamic styling (for multiiple devices)
  late MediaQueryData _mediaQueryData;
  late double screenWidth;
  late double screenHeight;
  late List<Activity> currentActivities;
  late List<Activity> moreActivities;
  late ColourScheme theme;

  @override
  void initState() {
    super.initState();
    refreshMyActivities();
  }

  @override
  void dispose() {
    ActivitiesDatabase.instance.close();
    super.dispose();
  }

  Future refreshMyActivities() async {
    print("***Refreshing***");
    List<Activity> tempList =
        await ActivitiesDatabase.instance.readAllActivities();
    Provider.of<ActivityProvider>(context, listen: false)
        .refreshMyActivityFromDatabase(tempList);

    List<Activity> tempList2 =
        await ActivitiesDatabase.instance.readAllActivities2();
    Provider.of<ActivityProvider>(context, listen: false)
        .refreshMyActivityFromDatabase2(tempList2);
  }

  refresh() {
    setState(() {});
  }

// Primary (orange banner), secondary (dark blue), tertiary (purple), quaternary (white), and quinary (button colour/) colours from a provider
  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context).currentTheme;
    // widget.backgroundColor = theme.secondary;
    // widget.textColor = theme.primary;
    // widget.appBarTextColor = theme.secondary;
    // widget.appBarColor = theme.primary;
    // widget.appBarTextColor = theme.secondary;
    // widget.appBarIconColor = theme.secondary;
    // widget.floatingButtonColor = theme.primary;

    widget.backgroundColor = theme.secondary;
    widget.textColor = theme.quaternary;
    widget.appBarTextColor = theme.secondary;
    widget.appBarColor = theme.primary;
    widget.appBarTextColor = theme.secondary;
    widget.appBarIconColor = theme.secondary;
    widget.floatingButtonColor = theme.primary;
    currentActivities =
        Provider.of<ActivityProvider>(context).currentActivities;
    moreActivities = Provider.of<ActivityProvider>(context).moreActivities;

    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
              bottomNavigationBar:
                  _bottomNavbar(), // delete later.... for testing purpose for colour schemes
              appBar: AppBar(
                title: Text(widget.title,
                    style: TextStyle(color: widget.appBarTextColor)),
                backgroundColor: widget.appBarColor,
                actions: [
                  IconButton(
                      onPressed: () {
                        //Navigator.of(context).push(MaterialPageRoute(
                        //    builder: (context) => HomePage()));
                        Navigator.pop(context, false);
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
                ],
              ));
        });
  }

// Floating Action Button
// When pushed, it should navigate to the create activity page
  Builder _createNewActivity() {
    Color? iconColor = widget.appBarTextColor;
    return Builder(builder: (context) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateNewActivityPage()));
        },
        backgroundColor: widget.floatingButtonColor,
        child: Icon(Icons.add_outlined, color: iconColor),
      );
    });
  }

// Reorder List View to show "Current (My) Activities"
  ListView _reorderableCurrentActivitiesView() {
    return ListView(
      shrinkWrap: true,
      children: [..._currentActivities()],
    );
  }

// Reorder List View for to show "More Activities"
  ListView _reorderableMoreActivitiesView() {
    return ListView(
      shrinkWrap: true,
      children: [..._moreActivities()],
    );
  }

// return a List of "More Activity" Cards
  List<Widget> _moreActivities() {
    List<Widget> activities = [];

    for (int index = 0; index < moreActivities.length; index++) {
      var newActivity = moreActivities[index];
      activities.add(MoreActivityCard(
        setStateOfAcitivity: refresh,
        activityIcon: newActivity.activityIcon,
        activity: newActivity.activity,
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
        activityIcon: activity.activityIcon,
        activity: activity.activity,
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
          style:
              TextStyle(color: widget.textColor, fontWeight: FontWeight.bold),
        ));
  }

// for testing purposes
  int _selectedIndex = 0;
  SizedBox _bottomNavbar() {
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: widget.backgroundColor,
        selectedItemColor: widget.textColor,
        unselectedItemColor: widget.textColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "1"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "2"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "3"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "4"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "5"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "6"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "7"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "8"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "9"),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined), label: "10")
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Provider.of<ThemeProvider>(context, listen: false).changeTheme(index);
    });
  }
}
