// main.dart
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:activityforecast/pages/SettingsPage.dart';
import 'package:activityforecast/pages/manage_activities.dart';
import 'package:activityforecast/view/pages/edit_activity_page.dart';

import 'package:provider/provider.dart';

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
  //late Location location;
  WeatherModel weather = WeatherModel();
  DateTime date = DateTime.now();

  late int temperature;
  late int temperatureMin;
  late int temperatureMax;
  late String weatherIcon;
  late String cityName;
  late String dayName = '';
  late String weatherCondition;


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

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        temperatureMin = 0;
        temperatureMax = 0;
        weatherIcon = 'Error';
        cityName = '';
        weatherCondition = '';
        return;
      }

      /*
      var temp = weatherData['current']['temp'];
      temperature = temp.toInt();

      var tempMin = weatherData['current']['humidity'];
      temperatureMin = tempMin.toInt();

      var tempMax = weatherData['current']['temp'];
      temperatureMax = tempMax.toInt();

      //var condition = weatherData['weather'][0]['id'];
      //weatherIcon = weather.getWeatherIcon(condition);

      cityName = weatherData['timezone'];

      dayName = DateFormat('EEEE').format(date);

      //weatherCondition = weatherData['weather'][0]['main'];
       */

      // current weather API (not one call)
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var tempMin = weatherData['main']['temp_min'];
      temperatureMin = tempMin.toInt();

      var tempMax = weatherData['main']['temp_max'];
      temperatureMax = tempMax.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);

      cityName = weatherData['name'];

      dayName = DateFormat('EEEE').format(date);

      weatherCondition = weatherData['weather'][0]['main'];
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

    // !<!<!< store position later for weather API
    //Future<Position> location = _determinePosition();
    //_determinePosition().then((value) => location1 = value as Location);

    //Position pos = _determinePosition();
    //getInitialLocation();

    var kCityNameTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      fontSize: 48.0,
      color: widget.textColor,
    );

    var kTimeTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 32.0,
      color: widget.textColor,
    );

    var kTemperatureTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      fontSize: 80.0,
      color: widget.textColor,
    );

    var kConditionTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 24.0,
      color: widget.textColor,
    );

    var kSmallTemperatureTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 32.0,
      color: widget.textColor,
    );


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
                            print(value);
                            cityInput = value;
                            if (cityInput != null) {
                              // !<!<!< var weatherData = await weather.getCityWeather(cityInput);
                              // !<!<!< updateUI(weatherData);
                            }
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
                          // !<!<!< var weatherData = await weather.getCityWeather(cityInput);
                          // !<!<!< updateUI(weatherData);
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
                Row(
                    children: forecastRow(
                        day: '$dayName',
                        valid: Icons.check,
                        weather: Icons.wb_sunny, // $weatherIcon or $weatherCondition?
                        temperature: '$temperature°, $temperatureMin° low')),
                Row(
                    children: forecastRow(
                        day: "Fri",
                        valid: Icons.clear_rounded,
                        weather: Icons.wb_cloudy,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Sat",
                        valid: Icons.check,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Sun",
                        valid: Icons.clear_rounded,
                        weather: Icons.wb_twilight,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Mon",
                        valid: Icons.check,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Tue",
                        valid: Icons.clear_rounded,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),
                Row(
                    children: forecastRow(
                        day: "Wed",
                        valid: Icons.check,
                        weather: Icons.wb_sunny,
                        temperature: "16°,13° low")),

                /*
                Container(
                  alignment: Alignment.center,
                  // constraints: BoxConstraints.expand(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              '$cityName',
                              style: kCityNameTextStyle,
                            ),
                          ),
                          Text(
                            '$dayName',
                            style: kTimeTextStyle,
                          ),
                        ],
                      ),
                      //Image.asset(
                      //  'images/$weatherIcon.png',
                      //  height: 160,
                      //),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(
                              '$temperature°',
                              style: kTemperatureTextStyle,
                            ),
                          ),
                          Text(
                            '$weatherCondition'.toUpperCase(),
                            style: kConditionTextStyle,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Image.asset(
                          //  'images/thermometer_low.png',
                          //  height: 50,
                          //),
                          Text(
                            '$temperatureMin°',
                            style: kSmallTemperatureTextStyle,
                          ),
                          //Image.asset(
                          //  'images/thermometer_high.png',
                          //  height: 50,
                          //),
                          Text(
                            '$temperatureMax°',
                            style: kSmallTemperatureTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                 */

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
                  child: Image.asset('assets/images/GoogleMapExample.jpg'),
                )
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

  List<Widget> forecastRow({day: "Today", valid: Icons.check, weather: Icons.wb_sunny, temperature = "900°,900° low"}) {
    return <Widget>[
      Expanded(
          flex: 1,
          child: Container(
              width: 1440 * 0.25,
              child: Text(day,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: widget.textColor)))),
      Expanded(
          flex: 1,
          child: Container(
            width: 1440 * 0.25,
            child: Icon(
              valid,
              color: widget.textColor,
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
            width: 1440 * 0.25,
            child: Icon(
              weather,
              color: widget.textColor,
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
              width: 1440 * 0.25,
              child: Text(temperature,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: widget.textColor)))),
    ];
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

  void getInitialLocation() async {
    //_determinePosition().then((value) => location1 = value as Location);
    _determinePosition();

    //var weatherData = await weather.getWeather(location1);
    var weatherData = await weather.getLocationWeather();
    // !<!<!< updateUI(weatherData);
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