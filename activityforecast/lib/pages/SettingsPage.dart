import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Settings',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: [IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pop(context, false),
          ),]
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
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                          'Celsius(°C)',
                          style: TextStyle(
                            color: Color(0xff262626),
                          ),
                          textAlign: TextAlign.left,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffffffff)
                      )
                  ),
                ),
                Icon(Icons.check),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Farenheit(°F)',
                        style: TextStyle(
                          color: Color(0xff262626),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffffffff)
                      )
                  ),
                ),
                Icon(Icons.check),
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
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      )
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff262626)
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
