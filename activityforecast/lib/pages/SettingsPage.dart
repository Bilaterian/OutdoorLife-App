import 'dart:ui';
import 'package:activityforecast/models/theme.dart';
import 'package:activityforecast/models/theme_provider.dart';
import 'package:activityforecast/view/pages/home_page.dart';

import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:activityforecast/models/temperature_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    setInit();
  }

  Future<void> setInit() async{
    final SharedPreferences prefs = await _prefs;
    Provider.of<TemperatureProvider>(context, listen: false).setUnit(prefs.getBool('unit') ?? false);
    Provider.of<TemperatureProvider>(context, listen: false).setNotif(prefs.getBool('notification') ?? false);
  }

  Future<void> setUnit() async{
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('unit', Provider.of<TemperatureProvider>(context, listen: false).getTemperatureSelect());
  }

  Future<void> setNotif() async{
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('notification', Provider.of<TemperatureProvider>(context, listen: false).getNotifications());
  }
  late List themes;

  int _selectedThemeIndex = 0;

  @override
  build(BuildContext context) {
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
                "Temperature",
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Celsius/Fahrenheit",
                    style: TextStyle(
                        fontSize: 15,
                        color: widget.textColor
                    ),
                  )
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Provider.of<TemperatureProvider>(context, listen: false).changeTempSelect();
                          setUnit();
                        });
                      },
                      child: Card(
                        color: widget.boxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<TemperatureProvider>(context, listen: false).getTemperatureSelect() ?
                          Text(
                            'Celsius(°C)',
                            style: TextStyle(
                              color: widget.activityContentsColor,
                            ),
                            textAlign: TextAlign.left,
                          ) :
                          Text(
                            'Fahrenheit(°F)',
                            style: TextStyle(
                              color: widget.activityContentsColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Notifications",
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "On/Off",
                      style: TextStyle(
                          fontSize: 15,
                          color: widget.textColor
                      ),
                    )
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Provider.of<TemperatureProvider>(context, listen: false).switchNotifications();
                          setNotif();
                        });
                      },
                      child: Card(
                        color: widget.boxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<TemperatureProvider>(context, listen: false).getNotifications() ?
                          Text(
                            'On',
                            style: TextStyle(
                              color: widget.activityContentsColor,
                            ),
                            textAlign: TextAlign.left,
                          ) :
                          Text(
                            'Off',
                            style: TextStyle(
                              color: widget.activityContentsColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
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
                      Provider.of<TemperatureProvider>(context, listen: false).resetTemp();
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
