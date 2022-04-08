import 'dart:ui';
import 'package:activityforecast/view/pages/home_page.dart';

import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/theme.dart';
import '../models/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  //SettingsPage({Key? key}) : super(key: key);

  late Color? activityContentsColor;
  late Color? backgroundColor;
  late Color? boxColor;
  late Color? textColor;
  late Color? appBarColor;
  late Color? appBarContentsColor;
  late Color? floatingButtonColor;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ColourScheme theme;

  int selectedIndex = 0;
  List selected = [false, false];

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context).currentTheme;

    widget.activityContentsColor = theme.secondary;

    widget.backgroundColor = theme.secondary;
    widget.textColor = theme.quaternary;
    widget.boxColor = theme.quinary;
    widget.appBarColor = theme.primary;
    widget.appBarContentsColor = theme.secondary;
    widget.floatingButtonColor = theme.primary;

    return MaterialApp(
      title: 'Settings',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: AppBar(
          backgroundColor: widget.appBarColor,
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: widget.appBarContentsColor),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage())),
            )
          ],
          // leading: IconButton(
          //   icon: const Icon(Icons.home, color: Color(0xff031342)),
          //   onPressed: () => Navigator.pop(context, false),
          // ),
          title: Text('Settings', style: TextStyle(color: widget.appBarContentsColor)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                " Temperature",
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
                        color: (selected[0]) ? Color(0xff4ad7d9) : widget.boxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Celsius(°C)',
                            style: TextStyle(color: widget.activityContentsColor),
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
                    color: (selected[1]) ? Color(0xff4ad7d9) : widget.boxColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Farenheit(°F)',
                        style: TextStyle(
                          color: widget.activityContentsColor,
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
                " Restore to Default Settings",
                style: TextStyle(fontSize: 16, color: widget.textColor, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                color: widget.floatingButtonColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Reset',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      )),
                  style: ElevatedButton.styleFrom(primary: widget.floatingButtonColor)),
            ),
          ],
        ),
      ),
    );
  }
}
