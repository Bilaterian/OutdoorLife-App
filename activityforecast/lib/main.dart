// main.dart
import 'package:flutter/material.dart';
import 'dart:ui';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget activityBox({size1: 82.0, size2: 82.0, colour: Colors.green, icon: Icons.directions_walk, text: "Walk", valid: Icons.check}) {
    return SizedBox.fromSize(
      size: Size(size1, size2), // button width and height
      child: Material(
      color: colour, // button color
      child: InkWell(
        onTap: () {}, // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon), // icon
            Text(text), // text
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
          child: Text(day, textAlign: TextAlign.center)
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
          child: Text(temperature, textAlign: TextAlign.center)
        )
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    String selectedActivity = "Bike";

    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Colors.deepPurpleAccent),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Boxicons Plugin'),
        ),
        body: Column(children: <Widget>[
          // Activity Rows
          Row(
              children: <Widget>[
                activityBox(icon: Icons.directions_bike, text: "Bike", valid: Icons.check),
                activityBox(icon: Icons.directions_boat, text: "Boat", valid: Icons.check),
                activityBox(colour: Colors.red, icon: Icons.snowboarding, text: "Snowboard", valid: Icons.check),
                activityBox(icon: Icons.add_photo_alternate, text: "Example", valid: Icons.clear_rounded),
                activityBox(size1: 83.0, colour: Colors.red, icon: Icons.wash, text: "Example", valid: Icons.check),
              ]
          ),
          Row(
              children: <Widget>[
                activityBox(icon: Icons.car_rental, text: "Example", valid: Icons.check),
                activityBox(icon: Icons.self_improvement, text: "Example", valid: Icons.check),
                activityBox(icon: Icons.campaign, text: "Example", valid: Icons.check),
                activityBox(icon: Icons.airplanemode_active, text: "Example", valid: Icons.clear_rounded),
                SizedBox.fromSize(
                  size: Size(82, 83), // button width and height
                  child: Material(
                    color: Colors.deepPurple, // button color
                    child: InkWell(
                      onTap: () {}, // button pressed
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
          Row(children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    width: 1440 * 0.75,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        selectedActivity + " Forecast",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                )
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: 1440 * 0.25,
                  child:               TextButton(
                      child: Text("EDIT"),
                      onPressed: () {
                        print("Pressed");
                      }
                  ),
                )
            ),
            /*
              Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                                selectedActivity + " Forecast",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
              ),
              TextButton(
                  child: Text("EDIT"),
                    onPressed: () {
                      print("Pressed");
                    }
              ),

             */
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
    );
  }
}

void main() {
  runApp(const MyApp());
}