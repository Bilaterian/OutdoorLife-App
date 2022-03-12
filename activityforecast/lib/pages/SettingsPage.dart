import 'dart:ui';
import 'package:activityforecast/HomePage.dart';

import 'package:activityforecast/components/themes/manage_activities_colors.dart';

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected[0] = !selected[0];
                          selected[1] = false;
                        });
                      },
                      child: Card(
                        color: (selected[0]) ? Color(0xff4ad7d9) : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Celsius(°C)',
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      selected[1] = !selected[1];
                      selected[0] = false;
                    });
                  },
                  child: Card(
                    color: (selected[1]) ? Color(0xff4ad7d9) : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        'Farenheit(°F)',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Restore to Default Settings",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff262626),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Reset',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      )),
                  style: ElevatedButton.styleFrom(primary: Color(0xff262626))),
            ),
          ],
        ),
      ),
    );
  }
}
