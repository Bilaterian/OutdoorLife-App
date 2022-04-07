import 'dart:ui';
import 'package:activityforecast/HomePage.dart';

import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:activityforecast/models/temperature_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Celsius/Fahrenheit",
                    style: TextStyle(fontSize: 15, color: Colors.white),
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
                        Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<TemperatureProvider>(context, listen: false).getTemperatureSelect() ?
                          const Text(
                            'Celsius(°C)',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ) :
                          const Text(
                            'Fahrenheit(°F)',
                            style: TextStyle(
                              color: Colors.black,
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
                      "Min/Max Temperature",
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                        Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<TemperatureProvider>(context, listen: false).getInvert() ?
                          const Text(
                            'Inclusive',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ) :
                          const Text(
                            'Exclusive',
                            style: TextStyle(
                              color: Colors.black,
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
                      "On/Off",
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                        Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<TemperatureProvider>(context, listen: false).getNotifications() ?
                          const Text(
                            'On',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ) :
                          const Text(
                            'Off',
                            style: TextStyle(
                              color: Colors.black,
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
