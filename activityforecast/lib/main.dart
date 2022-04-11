// main.dart hi
import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:activityforecast/models/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/view/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'models/temperature_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ActivityProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => TemperatureProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}
