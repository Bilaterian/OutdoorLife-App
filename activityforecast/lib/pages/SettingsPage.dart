import 'dart:ui';
import 'package:activityforecast/models/theme.dart';
import 'package:activityforecast/models/theme_provider.dart';
import 'package:activityforecast/view/pages/home_page.dart';

import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:activityforecast/models/temperature_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              onPressed: () => Navigator.pop(context, false),
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
                        });
                      },
                      child: Card(
                        color: Provider.of<TemperatureProvider>(context, listen: false).getTemperatureSelect() ?
                        Color(0xff4ad7d9) :
                        widget.boxColor,
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
                "Notification Range",
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
                      "Min/Max Temperature",
                      style: TextStyle(
                          fontSize: 15,
                          color: widget.textColor
                      ),
                    )
                ),
                RangeSlider(
                  values: RangeValues(
                      Provider.of<TemperatureProvider>(context, listen: false).getCurrMin(),
                      Provider.of<TemperatureProvider>(context, listen: false).getCurrMax()
                  ),
                  min: Provider.of<TemperatureProvider>(context, listen: false).getMin(),
                  max: Provider.of<TemperatureProvider>(context, listen: false).getMax(),
                  divisions: 80,
                  labels: RangeLabels(
                    Provider.of<TemperatureProvider>(context, listen: false).getCurrMin().toString(),
                    Provider.of<TemperatureProvider>(context, listen: false).getCurrMax().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      Provider.of<TemperatureProvider>(context, listen: false).setCurrMin((values.start.round()).toDouble());
                      Provider.of<TemperatureProvider>(context, listen: false).setCurrMax((values.end.round()).toDouble());
                    });
                  },
                )
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Inclusive/Exclusive Temperature Range",
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
                          Provider.of<TemperatureProvider>(context, listen: false).invertTempRange();
                        });
                      },
                      child: Card(
                        color: Provider.of<TemperatureProvider>(context, listen: false).getInvert() ?
                        Color(0xff4ad7d9) :
                        widget.boxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<TemperatureProvider>(context, listen: false).getInvert() ?
                          Text(
                            'Inclusive',
                            style: TextStyle(
                              color: widget.activityContentsColor,
                            ),
                            textAlign: TextAlign.left,
                          ) :
                          Text(
                            'Exclusive',
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
                        });
                      },
                      child: Card(
                        color: Provider.of<TemperatureProvider>(context, listen: false).getNotifications() ?
                        Color(0xff4ad7d9) :
                        widget.boxColor,
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
          ],
        ),
      ),
    );
  }
}
