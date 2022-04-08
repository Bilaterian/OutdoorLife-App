// main.dart
import 'package:flutter/material.dart';
import 'package:activityforecast/pages/SettingsPage.dart';
import 'package:activityforecast/pages/manage_activities.dart';
import 'package:activityforecast/view/pages/edit_activity_page.dart';

import 'package:provider/provider.dart';

import '../../models/theme.dart';
import '../../models/theme_provider.dart';

class HomePage extends StatefulWidget {

  late Color? activityContentsColor;
  late Color? backgroundColor;
  late Color? boxColor;
  late Color? textColor;
  late Color? appBarColor;
  late Color? appBarTextColor;
  late Color? appBarIconColor;
  late Color? floatingButtonColor;

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  late ColourScheme theme;

  String selectedActivity = "Bike";
  changeActivity(String activity) {
    setState(() {
      selectedActivity = activity;
    });
  }

  int numActivitiesPerRow = 5;
  int numRows = 2;
  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context).currentTheme;

    widget.activityContentsColor = theme.secondary;

    widget.backgroundColor = theme.secondary;
    widget.textColor = theme.quaternary;
    widget.boxColor = theme.quinary;
    widget.appBarColor = theme.primary;
    widget.appBarTextColor = theme.secondary;
    widget.appBarIconColor = theme.secondary;
    widget.floatingButtonColor = theme.primary;


    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidth = (screenWidth/numActivitiesPerRow).floorToDouble();
    double boxWidthIfExtraPixel = boxWidth;
    if (boxWidth != screenWidth/numActivitiesPerRow) {
      boxWidthIfExtraPixel = boxWidth + 1.0;
    }

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: widget.backgroundColor),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          //"/": (BuildContext context) => MaterialApp(home: MyApp()),
          "/ManageActivities": (BuildContext context) =>MainActivitiesPage(title: "Manage Activities"),
          "/EditActivityPage": (BuildContext context) => EditActivityPage(),
          "/SettingsPage": (BuildContext context) => SettingsPage(),
        },
        home: Builder(
          builder: (context) =>
          //home: Scaffold(
          Scaffold(
              backgroundColor: widget.backgroundColor,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: widget.appBarColor,
                title: Text('OutdoorLife', style: TextStyle(color: widget.appBarTextColor)),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/SettingsPage");
                      },
                      icon: Icon(Icons.settings, color: widget.appBarIconColor))
                ],
              ),
              body: Column(children: <Widget>[
                // Location Text Field
                TextField(
                  style: TextStyle(color: widget.textColor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search Map',
                    hintStyle: TextStyle(color: widget.textColor),
                  ),
                ),

                // Activities Validity
                Row(
                    children: <Widget>[
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.directions_bike, text: "Bike", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.directions_boat, text: "Boat", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.snowboarding, text: "Snowboard", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.add_photo_alternate, text: "Photos", valid: Icons.clear_rounded),
                      activityBox(size1: boxWidthIfExtraPixel, size2: boxWidth, icon: Icons.wash, text: "Clean", valid: Icons.check),
                    ]
                ),
                Row(
                    children: <Widget>[
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.car_rental, text: "Drive", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.self_improvement, text: "Meditate", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.campaign, text: "Protest", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.airplanemode_active, text: "Travel", valid: Icons.clear_rounded),
                      SizedBox.fromSize(
                        size: Size(boxWidthIfExtraPixel, boxWidth), // button width and height
                        child: Material(
                          color: widget.boxColor, // button color
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/ManageActivities");
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("+", style: TextStyle(fontSize: 50, color: widget.activityContentsColor)), // text
                              ],
                            ),
                          ),
                        ),
                      )
                    ]
                ),

                // Activity Forecast
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              '$selectedActivity' + " Forecast",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: widget.textColor,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(primary: widget.textColor),
                            child: Text("EDIT",
                                style: TextStyle(
                                    fontSize: 18, color: widget.textColor)),
                            onPressed: () {
                              //print("Edit Button Pressed");
                              Navigator.of(context)
                                  .pushNamed("/EditActivityPage");
                            })
                      ]),
                ),
                Row(
                    children: forecastRow(
                        day: "Today",
                        valid: Icons.check,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Fri",
                        valid: Icons.clear_rounded,
                        weather: Icons.wb_cloudy,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Sat",
                        valid: Icons.check,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Sun",
                        valid: Icons.clear_rounded,
                        weather: Icons.wb_twilight,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Mon",
                        valid: Icons.check,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Tue",
                        valid: Icons.clear_rounded,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Wed",
                        valid: Icons.check,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
                  child: Image.asset('assets/images/GoogleMapExample.jpg'),
                )
              ])),
        )
    );
  }

  Widget activityBox({size1: 82.0, size2: 82.0, icon: Icons.directions_walk, text: "Walk", valid: Icons.check}) {
    return SizedBox.fromSize(
      size: Size(size1, size2), // button width and height
      child: Material(
        color: widget.boxColor, // button color
        child: InkWell(
          onTap: () => changeActivity(text),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: widget.activityContentsColor), // icon
              Text(
                text, style: TextStyle(color: widget.activityContentsColor)
              ), // text
              Icon(
                valid,
                color: widget.activityContentsColor?.withOpacity(.7),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> forecastRow(
      {day: "Today",
        valid: Icons.check,
        weather: Icons.wb_sunny,
        temperature = "900°,900° low"}) {
    return <Widget>[
      Expanded(
          flex: 1,
          child: Container(
              width: 1440 * 0.25,
              child: Text(day,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: widget.textColor)))),
      Expanded(
          flex: 1,
          child: Container(
            width: 1440 * 0.25,
            child: Icon(
              valid,
              color: widget.textColor,
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
            width: 1440 * 0.25,
            child: Icon(
              weather,
              color: widget.textColor,
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
              width: 1440 * 0.25,
              child: Text(temperature,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: widget.textColor)))),
    ];
  }
}