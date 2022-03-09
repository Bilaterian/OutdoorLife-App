// main.dart
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  //static String selectedActivity = "Bike";

  //_MyAppState createState() => _MyAppState();

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  //const MyApp({Key? key}) : super(key: key);

  String selectedActivity = "Bike";
  changeActivity(String activity) {
    setState(() {
      selectedActivity = activity;
    });
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

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Colors.deepPurpleAccent),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OutdoorLife'),
        ),
        body: Column(children: <Widget>[
          // Activity Rows
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
                        print("Add Activity Button Pressed");
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
                    print("Edit Button Pressed");
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
    );
  }
}

void main() {
  runApp(MyApp());
}