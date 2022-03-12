// main.dart
import 'package:flutter/material.dart';
import 'package:activityforecast/pages/SettingsPage.dart';
import 'package:activityforecast/pages/manage_activities.dart';
import 'package:activityforecast/view/pages/edit_activity_page.dart';

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  String selectedActivity = "Bike";
  changeActivity(String activity) {
    setState(() {
      selectedActivity = activity;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.deepPurpleAccent),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        //"/": (BuildContext context) => MaterialApp(home: MyApp()),
        "/ManageActivities": (BuildContext context) => MaterialApp(home: MainActivitiesPage(title: "Manage Activities")),
        "/EditActivityPage": (BuildContext context) => MaterialApp(home: EditActivityPage()),
        "/SettingsPage": (BuildContext context) => MaterialApp(home: SettingsPage()),
      },
      home: Builder(
      builder: (context) =>
    //home: Scaffold(
      Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('OutdoorLife', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/SettingsPage");
              },
              icon: Icon(Icons.settings, color: Colors.black))
        ],
      ),
      body: Column(children: <Widget>[
          // Location Text Field
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search Map',
            ),
          ),

          // Activities Validity
          Row(
              children: <Widget>[
                activityBox(icon: Icons.directions_bike, text: "Bike", valid: Icons.check),
                activityBox(icon: Icons.directions_boat, text: "Boat", valid: Icons.check),
                activityBox(colour: Colors.deepPurple, icon: Icons.snowboarding, text: "Snowboard", valid: Icons.check),
                activityBox(icon: Icons.add_photo_alternate, text: "Photos", valid: Icons.clear_rounded),
                activityBox(size1: 83.0, colour: Colors.deepPurple, icon: Icons.wash, text: "Clean", valid: Icons.check),
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('$selectedActivity' + " Forecast",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),

                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.black),
                  child: Text("EDIT", style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/EditActivityPage");
                  }
                )
              ]
          ),
          Row(children: forecastRow(day: "Today", valid: Icons.check, weather: Icons.wb_sunny, temperature: "16°,13° low")),
          Row(children: forecastRow(day: "Fri", valid: Icons.clear_rounded, weather: Icons.wb_cloudy, temperature: "16°,13° low")),
          Row(children: forecastRow(day: "Sat", valid: Icons.check, weather: Icons.wb_sunny, temperature: "16°,13° low")),
          Row(children: forecastRow(day: "Sun", valid: Icons.clear_rounded, weather: Icons.wb_twilight, temperature: "16°,13° low")),
          Row(children: forecastRow(day: "Mon", valid: Icons.check, weather: Icons.wb_sunny, temperature: "16°,13° low")),
          Row(children: forecastRow(day: "Tue", valid: Icons.clear_rounded, weather: Icons.wb_sunny, temperature: "16°,13° low")),
          Row(children: forecastRow(day: "Wed", valid: Icons.check, weather: Icons.wb_sunny, temperature: "16°,13° low")),
        ])
      ),
    )
    );
  }

  Widget activityBox({size1: 82.0, size2: 82.0, colour: Colors.deepPurple, icon: Icons.directions_walk, text: "Walk", valid: Icons.check}) {
    return SizedBox.fromSize(
      size: Size(size1, size2), // button width and height
      child: Material(
        color: colour, // button color
        child: InkWell(
          onTap: () => changeActivity(text),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon), // icon
              Text(text), // text
              Icon(valid)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> forecastRow({day: "Today", valid: Icons.check, weather: Icons.wb_sunny, temperature = "900°,900° low"}) {
    return <Widget>[
      Expanded(
          flex: 1,
          child: Container(
              width: 1440 * 0.25,
              child: Text(day, textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
          )
      ),
      Expanded(
          flex: 1,
          child: Container(
            width: 1440 * 0.25,
            child: Icon(valid),
          )
      ),
      Expanded(
          flex: 1,
          child: Container(
            width: 1440 * 0.25,
            child: Icon(weather),
          )
      ),
      Expanded(
          flex: 1,
          child: Container(
              width: 1440 * 0.25,
              child: Text(temperature, textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
          )
      ),
    ];
  }
}

void main() {
  runApp(MyApp());
}