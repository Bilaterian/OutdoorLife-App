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
  late List themes;

  int selectedIndex = 0;
  List selected = [false, false];
  int _selectedThemeIndex = 0;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context).currentTheme;

    themes = Provider.of<ThemeProvider>(context, listen: false).themes;

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
              onPressed: () => Navigator.pop(context, false),
            )
          ],
          title: Text('Settings',
              style: TextStyle(color: widget.appBarContentsColor)),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: (selected[0])
                            ? widget.boxColor
                            : widget.backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Celsius(°C)',
                            style: TextStyle(
                                color: selected[0]
                                    ? widget.appBarContentsColor
                                    : widget.textColor,
                                fontWeight: FontWeight.bold),
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
                    color: (selected[1])
                        ? widget.boxColor
                        : widget.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Farenheit(°F)',
                        style: TextStyle(
                            color: selected[1]
                                ? widget.appBarContentsColor
                                : widget.textColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            ..._themeTiles(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                " Restore to Default Settings",
                style: TextStyle(
                    fontSize: 16,
                    color: widget.textColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            // child:
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                color: widget.floatingButtonColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedThemeIndex = 0;
                    });
                  },
                  child: Text('Reset',
                      style: TextStyle(
                        color: widget.activityContentsColor,
                      )),
                  style: ElevatedButton.styleFrom(
                      primary: widget.floatingButtonColor)),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  List<Widget> _themeTiles() {
    List<Widget> widgets = [];
    widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text("Themes",
            style: TextStyle(
                color: widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold))));

    for (int i = 0; i < themes.length; i++) {
      ColourScheme theme = themes[i];
      widgets.add(Card(
          color: (i == _selectedThemeIndex)
              ? widget.boxColor
              : widget.backgroundColor,
          child: ListTile(
            onTap: () {
              setState(() {
                _selectedThemeIndex = i;
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme(_selectedThemeIndex);
              });
            },
            leading: Text(
              "Themes",
              style: TextStyle(
                color: (i == _selectedThemeIndex)
                    ? widget.appBarContentsColor
                    : widget.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: _colors(theme),
          )));
    }
    return widgets;
  }

  Widget _colors(ColourScheme colors) {
    Map colorMap = colors.toJson();
    List<Widget> widgets = [];
    for (var color in colorMap.values) {
      widgets.add(Material(
        color: Colors.transparent,
        shape: CircleBorder(side: BorderSide(color: Colors.black)),
        child: Icon(
          Icons.circle,
          color: color,
        ),
      ));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [...widgets],
    );
  }
}
