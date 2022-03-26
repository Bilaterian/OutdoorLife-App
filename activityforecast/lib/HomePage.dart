// main.dart
import 'package:flutter/material.dart';
import 'package:activityforecast/pages/SettingsPage.dart';
import 'package:activityforecast/pages/manage_activities.dart';
import 'package:activityforecast/view/pages/edit_activity_page.dart';
import 'package:provider/provider.dart';

import 'components/location_management.dart';
import 'components/map_display.dart';
import 'components/themes/manage_activities_colors.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  String selectedActivity = "Bike";
  changeActivity(String activity) {
    setState(() {
      selectedActivity = activity;
    });
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => LocationManagement(),
      child: MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: Colors.deepPurpleAccent),
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
                backgroundColor: Color(0xff031342),
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: manageActivityColors['appBarColor'],
                  title: const Text('OutdoorLife', style: TextStyle(color: Color(0xff031342))),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/SettingsPage");
                        },
                        icon: Icon(Icons.settings, color: Color(0xff031342)))
                  ],
                ),
                body: Column(children: <Widget>[
                  // Location Text Field
                  const TextField(//TextInput
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search Map',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),

                  // Activities Validity
                  Row(
                      children: <Widget>[
                        activityBox(icon: Icons.directions_bike, text: "Bike", valid: Icons.check),
                        activityBox(icon: Icons.directions_boat, text: "Boat", valid: Icons.check),
                        activityBox(icon: Icons.snowboarding, text: "Snowboard", valid: Icons.check),
                        activityBox(icon: Icons.add_photo_alternate, text: "Photos", valid: Icons.clear_rounded),
                        activityBox(size1: 83.0, icon: Icons.wash, text: "Clean", valid: Icons.check),
                      ]
                  ),
                  Row(
                      children: <Widget>[
                        activityBox(icon: Icons.car_rental, text: "Drive", valid: Icons.check),
                        activityBox(icon: Icons.self_improvement, text: "Meditate", valid: Icons.check),
                        activityBox(icon: Icons.campaign, text: "Protest", valid: Icons.check),
                        activityBox(icon: Icons.airplanemode_active, text: "Travel", valid: Icons.clear_rounded),
                        SizedBox.fromSize(
                          size: Size(83.0, 82.0), // button width and height
                          child: Material(
                            color: Colors.deepPurple, // button color
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("/ManageActivities");
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("+", style: TextStyle(fontSize: 50)), // text
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                              style:
                              TextButton.styleFrom(primary: Colors.black),
                              child: Text("EDIT",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
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
                    child: MapDisplay(),///THE MAP
                  )
                ]
                )
            ),
          )
      ),
    );
  }

  Widget activityBox(
      {size1: 82.0,
        size2: 82.0,
        // colour: Colors.deepPurple,
        icon: Icons.directions_walk,
        text: "Walk",
        valid: Icons.check}) {
    return SizedBox.fromSize(
      size: Size(size1, size2), // button width and height
      child: Material(
        color: Colors.white, // button color
        child: InkWell(
          onTap: () => changeActivity(text),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: Color(0xff3a0266)), // icon
              Text(
                text,
              ), // text
              Icon(
                valid,
                color: Color(0xff3a0266).withOpacity(.7),
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
                  style: TextStyle(fontSize: 16, color: Colors.white)))),
      Expanded(
          flex: 1,
          child: Container(
            width: 1440 * 0.25,
            child: Icon(
              valid,
              color: Colors.white,
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
            width: 1440 * 0.25,
            child: Icon(
              weather,
              color: Colors.white,
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
              width: 1440 * 0.25,
              child: Text(temperature,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white)))),
    ];
  }
}