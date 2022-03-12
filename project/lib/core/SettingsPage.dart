import 'dart:ui';
import 'package:project/ui/CelsiusButton.dart';
import 'package:project/ui/FarenheitButton.dart';
import 'package:project/ui/ResetButton.dart';
import 'package:flutter/material.dart';

import '../ui/CelsiusCheck.dart';
import '../ui/FarenheitCheck.dart';

class SettingsPage extends StatefulWidget{

  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Settings',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: const Text('Settings'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Temperature",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CelsiusButton(),
                ),
                CelsiusCheck(),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FarenheitButton(),
                ),
                FarenheitCheck(),
              ],
            ),
            Text(
              "Restore to Default Settings",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff262626),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ResetButton(),
            ),
          ],
        ),
      ),
    );
  }
}