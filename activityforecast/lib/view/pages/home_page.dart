// main.dart
//import 'dart:html';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:activityforecast/pages/SettingsPage.dart';
import 'package:activityforecast/pages/manage_activities.dart';
import 'package:activityforecast/view/pages/edit_activity_page.dart';

import 'package:provider/provider.dart';

import '../../components/weather_icons.dart';
import '../../models/activity.dart';
import '../../models/activity_provider.dart';
import '../../models/theme.dart';
import '../../models/theme_provider.dart';
import 'package:geolocator/geolocator.dart';

import '../../services/weather.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({this.locationWeather});

  final locationWeather;

  late Color? activityContentsColor;
  late Color? backgroundColor;
  late Color? boxColor;
  late Color? textColor;
  late Color? appBarColor;
  late Color? appBarTextColor;
  late Color? appBarIconColor;
  late Color? floatingButtonColor;

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  // colours
  late ColourScheme theme;
  //late Position _currentPosition;

  // city input
  late final _searchController = TextEditingController();
  String cityInput = "London";

  // weather info
  final int daysDisplaying = 7;
  //late Location location;
  WeatherModel weather = WeatherModel();
  List<DateTime> dates = [
    DateTime.now(),
    DateTime.now().add(Duration(days: 1)),
    DateTime.now().add(Duration(days: 2)),
    DateTime.now().add(Duration(days: 3)),
    DateTime.now().add(Duration(days: 4)),
    DateTime.now().add(Duration(days: 5)),
    DateTime.now().add(Duration(days: 6))
  ];
  List<String> dayNames = [
    'Today',
    'Day 2',
    'Day 3',
    'Day 4',
    'Day 5',
    'Day 6',
    'Day 7'
  ];

  List<int> temperatures = [0, 0, 0, 0, 0, 0, 0];
  List<int> temperaturesMin = [0, 0, 0, 0, 0, 0, 0];
  List<int> temperaturesMax = [0, 0, 0, 0, 0, 0, 0];

  List<String> weatherIconsName = [
    'sunny',
    'sunny',
    'sunny',
    'sunny',
    'sunny',
    'sunny',
    'sunny'
  ];
  late String dayName = '';
  late String weatherCondition;

  List<String> alert = [
    '',
    '',
    'No weather alerts in this location! Take care :)'
  ];

  late List<Activity> currentActivities;
  late List<String> activityNames = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ]; //activity.activity;
  late List<IconData> activityIcons = [
    Icons.directions_walk,
    Icons.directions_walk,
    Icons.directions_walk,
    Icons.directions_walk,
    Icons.directions_walk,
    Icons.directions_walk,
    Icons.directions_walk,
    Icons.directions_walk,
    Icons.directions_walk,
  ]; //activity.activityIcon;
  late List<IconData> activityValids = [
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
  ]; //activity.condition;

  late List<IconData> forecastActivityValids = [
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
    Icons.check_circle_outline,
  ]; //activity.condition;

  //Icons.close, Icons.check_circle_outline

  // selected activity
  late String selectedActivity;
  changeActivity(String activity, int index) {
    setState(() {
      selectedActivity = activity;
      selectedActivityIndex = index;
    });
  }

  late int selectedActivityIndex = 0;

  int numActivitiesPerRow = 5;
  int numRows = 2;

  @override
  void initState() {
    super.initState();

    getUserLocation();

    //updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        for (int i = 0; i < daysDisplaying; i++) {
          temperatures[i] = 0;
          temperaturesMin[i] = 0;
          temperaturesMax[i] = 0;
          weatherIconsName[i] = 'sunny';

          if (i < 3) {
            alert[i] = '';
          }
        }

        //cityName = '';
        weatherCondition = '';
        return;
      }

      // one call API
      for (int i = 0; i < daysDisplaying; i++) {
        var temp = weatherData['daily'][i]['temp']['day'];
        temperatures[i] = temp.toInt();

        var tempMin = weatherData['daily'][i]['temp']['min'];
        temperaturesMin[i] = tempMin.toInt();

        var tempMax = weatherData['daily'][i]['temp']['max'];
        temperaturesMax[i] = tempMax.toInt();

        if (i != 0) {
          // edit everything other than "Today" (since it's just "Today")
          dayNames[i] = DateFormat('EEEE').format(dates[i]);
        }

        var condition = weatherData['daily'][i]['weather'][0]['id'];
        weatherIconsName[i] = weather.getWeatherIcon(condition);
      }

      try {
        alert[0] = weatherData['alerts'][0]['sender_name'];
        alert[1] = weatherData['alerts'][0]['event'];
        alert[2] = weatherData['alerts'][0]['description'];
      } catch (e) {
        log("no alerts");
        alert[0] = '';
        alert[1] = '';
        alert[2] = 'No weather alerts in this location! Take care :)';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // colours
    theme = Provider.of<ThemeProvider>(context).currentTheme;

    widget.activityContentsColor = theme.secondary;
    widget.backgroundColor = theme.secondary;
    widget.textColor = theme.quaternary;
    widget.boxColor = theme.quinary;
    widget.appBarColor = theme.primary;
    widget.appBarTextColor = theme.secondary;
    widget.appBarIconColor = theme.secondary;
    widget.floatingButtonColor = theme.primary;

    // current activities
    currentActivities =
        Provider.of<ActivityProvider>(context).currentActivities;

    // dynamic sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidth = screenWidth / numActivitiesPerRow;
    //double boxWidthRounded = (screenWidth/numActivitiesPerRow).floorToDouble();
    double boxWidthIfExtraPixel = boxWidth;

    //if (boxWidthRounded != boxWidth) {
    //boxWidthIfExtraPixel = boxWidthRounded + (boxWidth - boxWidthRounded);
    //boxWidthIfExtraPixel = boxWidth + 1.0;
    //}

    // selected activity
    if (currentActivities.length > 0) {
      // a activity is forecasted

      bool currentActivity = false;
      for (int i = 0; i < currentActivities.length; i++) {
        if (i < (numActivitiesPerRow * numRows) - 1) {
          var activity = currentActivities[i];
          if (selectedActivity == activity.activity) {
            currentActivity = true;
          }
        }
      }

      if (!currentActivity) {
        selectedActivity = currentActivities[0].activity;
        selectedActivityIndex = 0;
      }
    } else {
      // no activity to forecast
      selectedActivity = "";
      selectedActivityIndex = -1;

      for (int i = 0; i < daysDisplaying; i++) {
        forecastActivityValids[i] = Icons.question_mark;
      }
    }

    // update activity info
    for (int i = 0; i < currentActivities.length; i++) {
      if (i < (numActivitiesPerRow * numRows) - 1) {
        var activity = currentActivities[i];
        activityNames[i] = activity.activity;
        activityIcons[i] = activity.activityIcon;

        // check if activity is ideal
        bool valid = true;
        if (temperatures[0] < activity.temperatures.end &&
            temperatures[0] > activity.temperatures.start) {
          // within temperature range
          String weather = weatherIconsName[0];
          switch (weather) {
            case 'sunny':
              if (!activity.isSunnyIdeal) {
                valid = false;
              }
              break;
            case 'fog':
              if (!activity.isFogIdeal) {
                valid = false;
              }
              break;
            case 'cloudy':
              if (!activity.isCloudyIdeal) {
                valid = false;
              }
              break;
            case 'drizzle':
              if (!activity.isDrizzleIdeal) {
                valid = false;
              }
              break;
            case 'rainy':
              if (!activity.isRainyIdeal) {
                valid = false;
              }
              break;
            case 'thunderstorm':
              if (!activity.isThunderstormIdeal) {
                valid = false;
              }
              break;
            case 'snowy':
              if (!activity.isSnowIdeal) {
                valid = false;
              }
              break;
            default:
              break;
          }
        }

        if (valid) {
          activityValids[i] = Icons.check_circle_outline;
        } else {
          activityValids[i] = Icons.close;
        }
      }
    }

    // update forecast activity info
    for (int i = 0; i < currentActivities.length; i++) {
      if (i < (numActivitiesPerRow * numRows) - 1) {
        var activity = currentActivities[i];

        if (selectedActivity == activity.activity) {
          // get validity for all days for the selected activity

          for (int j = 0; j < daysDisplaying; j++) {
            bool valid = true;

            if (temperatures[j] < activity.temperatures.end &&
                temperatures[j] > activity.temperatures.start) {
              // within temperature range
              String weather = weatherIconsName[j];
              switch (weather) {
                case 'sunny':
                  if (!activity.isSunnyIdeal) {
                    valid = false;
                  }
                  break;
                case 'fog':
                  if (!activity.isFogIdeal) {
                    valid = false;
                  }
                  break;
                case 'cloudy':
                  if (!activity.isCloudyIdeal) {
                    valid = false;
                  }
                  break;
                case 'drizzle':
                  if (!activity.isDrizzleIdeal) {
                    valid = false;
                  }
                  break;
                case 'rainy':
                  if (!activity.isRainyIdeal) {
                    valid = false;
                  }
                  break;
                case 'thunderstorm':
                  if (!activity.isThunderstormIdeal) {
                    valid = false;
                  }
                  break;
                case 'snowy':
                  if (!activity.isSnowIdeal) {
                    valid = false;
                  }
                  break;
                default:
                  break;
              } // condition switch
            } // temperature check

            if (valid) {
              forecastActivityValids[j] = Icons.check_circle_outline;
            } else {
              forecastActivityValids[j] = Icons.close;
            }
          }

          break;
        }
      }
    }

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: widget.backgroundColor),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          //"/": (BuildContext context) => MaterialApp(home: MyApp()),
          "/ManageActivities": (BuildContext context) =>
              MainActivitiesPage(title: "Manage Activities"),
          // "/EditActivityPage": (BuildContext context) => EditActivityPage(
          //       whichActivityList: ActivityList.more,
          //       activityToEditIndex: 3,
          //     ),
          "/SettingsPage": (BuildContext context) => SettingsPage(),
        },
        home: Builder(
          builder: (context) =>
              //home: Scaffold(
              Scaffold(
                  backgroundColor: widget.backgroundColor,
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor: widget.appBarColor,
                    title: Text('OutdoorLife',
                        style: TextStyle(color: widget.appBarTextColor)),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/SettingsPage");
                          },
                          icon: Icon(Icons.settings,
                              color: widget.appBarIconColor))
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                color: widget.textColor,
                              ),
                              child: Padding(
                                padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Icon(Icons.location_on,
                                    color: widget.backgroundColor),
                                ),
                              ),
                              onTap: () async {
                                getUserLocation();
                                _searchController.text = "";
                              },
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _searchController,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: widget.textColor, fontSize: 18
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: widget.backgroundColor,
                                    hintText: 'Enter City Name',
                                    hintStyle: TextStyle(
                                      color: widget.textColor, fontSize: 18),
                                    filled: true,
                                    border: OutlineInputBorder(),
                                  ),
                                  onSubmitted: (value) async {
                                  },
                                ),
                              ),
                            ),
                          InkWell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: widget.textColor,
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text('Search',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: widget.backgroundColor)),
                              ),
                            ),
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              print(_searchController.text);
                              cityInput = _searchController.text;
                              if (cityInput != null) {
                                var weatherData =
                                  await weather.getCityWeather(cityInput);
                              updateUI(weatherData);
                              }
                            },
                          )
                          ],
                        ),

                    // Activities Validity
                      Row(children: <Widget>[
                        activityBox(size1: boxWidth, size2: boxWidth, index: 0),
                        activityBox(size1: boxWidth, size2: boxWidth, index: 1),
                        activityBox(size1: boxWidth, size2: boxWidth, index: 2),
                        activityBox(size1: boxWidth, size2: boxWidth, index: 3),
                        activityBox(
                          size1: boxWidthIfExtraPixel,
                          size2: boxWidth,
                          index: 4),
                    ]),
                      Row(children: <Widget>[
                        activityBox(size1: boxWidth, size2: boxWidth, index: 5),
                        activityBox(size1: boxWidth, size2: boxWidth, index: 6),
                        activityBox(size1: boxWidth, size2: boxWidth, index: 7),
                        activityBox(size1: boxWidth, size2: boxWidth, index: 8),
                        SizedBox.fromSize(
                        size: Size(boxWidthIfExtraPixel,
                            boxWidth), // button width and height
                          child: Material(
                          color: widget.boxColor, // button color
                            child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("/ManageActivities");
                            }, // button pressed
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("+",
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: widget
                                            .activityContentsColor)), // text
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),

                    // Activity Forecast
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Text(
                                    '$selectedActivity' + " Forecast",
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: widget.textColor,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        (selectedActivityIndex != -1)
                                            ? widget.textColor
                                            : (widget.textColor as Color)
                                                .withOpacity(.5)),
                                child: Text("Edit",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: widget.backgroundColor)),
                                onPressed:
                                    //print("Edit Button Pressed");
                                    // Navigator.of(context)
                                    //     .push("/EditActivityPage");
                                    //
                                    (selectedActivityIndex == -1)
                                        ? null
                                        : () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return EditActivityPage(
                                                  activityToEditIndex:
                                                      selectedActivityIndex,
                                                  whichActivityList:
                                                      ActivityList.current,
                                                  list: currentActivities);
                                            }));
                                          })
                          ]),
                    ),
                        forecasts(),

                    // alerts
                        Center(
                          child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                          'ALERTS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: widget.textColor,
                          ),
                        ),
                      ),
                    ),
                        Center(
                            child: Container(
                                color: widget.boxColor,
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  children: [
                                    Text(
                                      '${alert[0]}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: widget.backgroundColor,
                                      ),
                                    ),
                                    Text(
                                      '\n${alert[1]}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: widget.backgroundColor,
                                      ),
                                    ),
                                    Text(
                                      '\n${alert[2]}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: widget.backgroundColor,
                                      ),
                                    )
                                  ],
                                ),
                            )
                        )
                      ]
                    ),
                ),
              ),
        ));
  }

  Widget activityBox({size1: 82.0, size2: 82.0, index: 0}) {
    bool show = index > currentActivities.length - 1 ? false : true;

    return SizedBox.fromSize(
      size: Size(size1, size2), // button width and height
      child: Material(
          color: widget.boxColor, // button color
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: InkWell(
              onTap: () => show
                  ? changeActivity(activityNames[index], index)
                  : log('clicked empty activity'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(activityIcons[index],
                      color: show
                          ? widget.activityContentsColor
                          : widget.boxColor), // icon
                  Text(activityNames[index],
                      style: TextStyle(
                          fontSize: 13,
                          color: show
                              ? widget.activityContentsColor
                              : widget.boxColor)), // text
                  Icon(
                    activityValids[index],
                    color: show
                        ? widget.activityContentsColor?.withOpacity(.7)
                        : widget.boxColor,
                  )
                ],
              ),
            ),
          )),
    );
  }

  List<Widget> forecastRow(
      {day: "Today",
      valid: Icons.check,
      weather: Icons.wb_sunny,
      temperature = "900°,900° low",
      screenWidth = 1440.0}) {
    return <Widget>[
      Expanded(
          flex: 1,
          child: Container(
              width: screenWidth * 0.25,
              child: Text(day,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: widget.textColor)))),
      Expanded(
          flex: 1,
          child: Container(
            width: screenWidth * 0.25,
            child: Icon(
              valid,
              color: widget.textColor,
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
            width: screenWidth * 0.25,
            child: Icon(
              weather,
              color: widget.textColor,
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
              width: screenWidth * 0.25,
              child: Text(temperature,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: widget.textColor)))),
    ];
  }

  Padding forecastPadding() {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 2.5));
  }

  Row completeForecastRow({day: 0, screenWidth: 1440.0}) {
    return Row(
        children: forecastRow(
      day: '${dayNames[day]}',
      valid: forecastActivityValids[day],
      weather: weatherIcons[weatherIconsName[day]],
      temperature: '${temperatures[day]}°, ${temperaturesMin[day]}° low',
      screenWidth: screenWidth,
    ));
  }

  Column forecasts({screenWidth: 1440.0}) {
    return Column(children: <Widget>[
      completeForecastRow(day: 0, screenWidth: screenWidth),
      forecastPadding(),
      completeForecastRow(day: 1, screenWidth: screenWidth),
      forecastPadding(),
      completeForecastRow(day: 2, screenWidth: screenWidth),
      forecastPadding(),
      completeForecastRow(day: 3, screenWidth: screenWidth),
      forecastPadding(),
      completeForecastRow(day: 4, screenWidth: screenWidth),
      forecastPadding(),
      completeForecastRow(day: 5, screenWidth: screenWidth),
      forecastPadding(),
      completeForecastRow(day: 6, screenWidth: screenWidth),
      forecastPadding(),
    ]);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    /*
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low).then((location) {
      if (location != null) {
        loc = location as Location;
        //print("Location: ${location.latitude},${location.longitude}");
        //locationRepository.store(location);
      }
      //return location;
    }

     */
  }

  void getUserLocation() async {
    //_determinePosition().then((value) => location1 = value as Location);
    _determinePosition();

    //var weatherData = await weather.getWeather(location1);
    var weatherData = await weather.getLocationWeather();
    updateUI(weatherData);
  }
}
