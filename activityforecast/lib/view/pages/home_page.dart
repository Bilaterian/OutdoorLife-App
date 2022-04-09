// main.dart
//import 'dart:html';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:activityforecast/pages/SettingsPage.dart';
import 'package:activityforecast/pages/manage_activities.dart';
import 'package:activityforecast/view/pages/edit_activity_page.dart';

import 'package:provider/provider.dart';

import '../../components/weather_icons.dart';
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
                          DateTime.now(), DateTime.now().add(Duration(days: 1)), DateTime.now().add(Duration(days: 2)), DateTime.now().add(Duration(days: 3)),
                          DateTime.now().add(Duration(days: 4)), DateTime.now().add(Duration(days: 5)), DateTime.now().add(Duration(days: 6))
                         ];
  List<String> dayNames = ['Today', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];

  List<int> temperatures = [0, 0, 0, 0, 0, 0, 0];
  List<int> temperaturesMin = [0, 0, 0, 0, 0, 0, 0];
  List<int> temperaturesMax = [0, 0, 0, 0, 0, 0, 0];

  List<String> weatherIconsName = ['sunny', 'sunny', 'sunny', 'sunny', 'sunny', 'sunny', 'sunny'];
  //late String cityName;
  late String dayName = '';
  late String weatherCondition;

  List<String> alert = ['', '', ''];

  // selected activity
  String selectedActivity = "Bike";
  changeActivity(String activity) {
    setState(() {
      selectedActivity = activity;
    });
  }

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
      } catch(e) {
          log("no alerts");
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

    // dynamic sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidth = screenWidth/numActivitiesPerRow;
    //double boxWidthRounded = (screenWidth/numActivitiesPerRow).floorToDouble();
    double boxWidthIfExtraPixel = boxWidth;

    //if (boxWidthRounded != boxWidth) {
      //boxWidthIfExtraPixel = boxWidthRounded + (boxWidth - boxWidthRounded);
      //boxWidthIfExtraPixel = boxWidth + 1.0;
    //}


    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: widget.backgroundColor),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          //"/": (BuildContext context) => MaterialApp(home: MyApp()),
          "/ManageActivities": (BuildContext context) =>MainActivitiesPage(title: "Manage Activities"),
          "/EditActivityPage": (BuildContext context) => EditActivityPage(),
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
                title: Text('OutdoorLife', style: TextStyle(color: widget.appBarTextColor)),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/SettingsPage");
                      },
                      icon: Icon(Icons.settings, color: widget.appBarIconColor))
                ],
              ),
              body: SingleChildScrollView(
              child: Column(children: <Widget>[
                /*
                // Location Text Field
                TextField(
                  style: TextStyle(color: widget.textColor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(color: widget.textColor),
                  ),
                ),
                 */
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
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.location_on, color: widget.backgroundColor),
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
                          style: TextStyle(color: widget.textColor, fontSize: 18),
                          decoration: InputDecoration(
                            fillColor: widget.backgroundColor,
                            hintText: 'Enter City Name',
                            hintStyle: TextStyle(color: widget.textColor, fontSize: 18),
                            filled: true,
                            border: OutlineInputBorder(
                            ),
                          ),
                          onSubmitted: (value) async {
                            /*
                            print(value);
                            cityInput = value;
                            if (cityInput != null) {
                              var weatherData = await weather.getCityWeather(cityInput);
                              updateUI(weatherData);
                            }
                             */
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
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text('Search',
                              style: TextStyle(fontSize: 18, color: widget.backgroundColor)),
                        ),
                      ),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        print(_searchController.text);
                        cityInput = _searchController.text;
                        if (cityInput != null) {
                          var weatherData = await weather.getCityWeather(cityInput);
                          updateUI(weatherData);
                        }
                      },
                    )
                  ],
                ),
                // Activities Validity
                Row(
                    children: <Widget>[
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.directions_bike, text: "Bike", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.directions_boat, text: "Boat", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.snowboarding, text: "Snowboard", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.add_photo_alternate, text: "Photos", valid: Icons.clear_rounded),
                      activityBox(size1: boxWidthIfExtraPixel, size2: boxWidth, icon: Icons.wash, text: "Clean", valid: Icons.check),
                    ]
                ),
                Row(
                    children: <Widget>[
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.car_rental, text: "Drive", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.self_improvement, text: "Meditate", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.campaign, text: "Protest", valid: Icons.check),
                      activityBox(size1: boxWidth, size2: boxWidth, icon: Icons.airplanemode_active, text: "Travel", valid: Icons.clear_rounded),
                      SizedBox.fromSize(
                        size: Size(boxWidthIfExtraPixel, boxWidth), // button width and height
                        child: Material(
                          color: widget.boxColor, // button color
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/ManageActivities");
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("+", style: TextStyle(fontSize: 50, color: widget.activityContentsColor)), // text
                              ],
                            ),
                          ),
                        ),
                      )
                    ]
                ),

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
                            style: TextButton.styleFrom(backgroundColor: widget.textColor),
                            child: Text("Edit",
                                style: TextStyle(
                                    fontSize: 18, color:  widget.backgroundColor)),
                            onPressed: () {
                              //print("Edit Button Pressed");
                              Navigator.of(context)
                                  .pushNamed("/EditActivityPage");
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
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      '${alert[0]}, ${alert[1]}, ${alert[2]}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: widget.textColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
                  child: Image.asset('assets/images/GoogleMapExample.jpg'),
                ),
              ]))),
        )
    );
  }

  Widget activityBox({size1: 82.0, size2: 82.0, icon: Icons.directions_walk, text: "Walk", valid: Icons.check}) {
    return SizedBox.fromSize(
      size: Size(size1, size2), // button width and height
      child: Material(
        color: widget.boxColor, // button color
        child: InkWell(
          onTap: () => changeActivity(text),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: widget.activityContentsColor), // icon
              Text(
                text, style: TextStyle(color: widget.activityContentsColor)
              ), // text
              Icon(
                valid,
                color: widget.activityContentsColor?.withOpacity(.7),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> forecastRow({day: "Today", valid: Icons.check, weather: Icons.wb_sunny, temperature = "900°,900° low", screenWidth = 1440.0}) {
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
          valid: Icons.check,
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
      ]
    );
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
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

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

/*
    getCurrentLocationAddress() async {
      try {
        List<Placemark> listPlaceMarks = await placemarkFromCoordinates(
            _currentPosition.latitude, currentPosition.longitude);
        Placemark place = listPlaceMarks[0];

        setState(() {
          currentLocationAddress = “${place.locality}, ${place.postalCode}, ${place.country}”;
        }
        );
      } catch (e) {
        print(e);
      }
    }
     */

}