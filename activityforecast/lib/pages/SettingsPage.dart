import 'dart:ui';
import 'package:activityforecast/HomePage.dart';
import 'package:activityforecast/components/temperature_provider.dart';

import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {

  bool temperatureSelect = TemperatureProvider().temperatureSelect;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selectedIndex = 0;
  List selected = [false, false];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Settings',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff031342),
        appBar: AppBar(
          backgroundColor: manageActivityColors['appBarColor'],
          actions: [
            IconButton(
              icon: const Icon(Icons.home, color: Color(0xff031342)),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage())),
            )
          ],
          // leading: IconButton(
          //   icon: const Icon(Icons.home, color: Color(0xff031342)),
          //   onPressed: () => Navigator.pop(context, false),
          // ),
          title: const Text('Settings',
              style: TextStyle(color: Color(0xff031342))),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Temperature",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Celsius/Farenheit",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Consumer<TemperatureProvider>(builder: (context, TemperatureProvider, child){
                  return Switch(
                    value: widget.temperatureSelect,
                    onChanged: (value) {
                      setState(() {
                        TemperatureProvider.changeTemperatureUnit();
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  );
                }),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
