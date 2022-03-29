import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:activityforecast/models/Condition.dart';
import 'package:activityforecast/models/activity.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

class CreateNewActivityPage extends StatefulWidget {
  CreateNewActivityPage({Key? key}) : super(key: key);
  List<bool> check_circle_selected = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  List<bool> close_selected = [false, false, false, false, false, false, false];

  RangeValues _currentRangeValues = const RangeValues(0, 80);

  String sliderLabel(int number) {
    int adjusted_num = 0;

    if (number < 40) {
      adjusted_num = 40 - number;
      return "-" + adjusted_num.toString();
    } else {
      adjusted_num = number - 40;
      return adjusted_num.toString();
    }
  }

  @override
  _CreateNewActivityPageState createState() => _CreateNewActivityPageState();
}

class _CreateNewActivityPageState extends State<CreateNewActivityPage> {
  // Widget activityIcon(IconData icon) {
  //   return IconButton(
  //     icon: Icon(Icons.check_circle_outline,
  //         size: 30,
  //         color: widget.check_circle_selected[i] == false
  //             ? Colors.black
  //             : Colors.green),
  //     onPressed: () {
  //       setState(() {
  //         widget.check_circle_selected[i] = !widget.check_circle_selected[i];
  //         widget.close_selected[i] = false;
  //       });
  //     },
  //   );
  // }

  int selectedActivity = -1;
  List<bool> icon1_selected = [false, false, false, false, false];
  List<bool> icon2_selected = [false, false, false, false, false];
  var selectedIcon;
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff010e33),
      appBar: AppBar(
          title: const Text('Create New Activity',
              style: TextStyle(color: Color(0xff031342))),
          backgroundColor: manageActivityColors['appBarColor'],
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(Icons.home, color: Color(0xff031342)),
            ),
          ]),
      body: buildNewActivityDetails(context),
    );
  }

  Widget buildNewActivityDetails(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            // left: 20,
          ),
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.white.withOpacity(0.5),
                ),
              )),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: TextFormField(
            validator: (value) {
              if ((value?.isEmpty ?? true)) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: activityNameController,
            style: TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              fillColor: Colors.white,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Enter the activity name',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Icon',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [..._activityRow1(_activityIcon1)],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [..._activityRow2(_activityIcon2)],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Colors.white.withOpacity(0.5)),
              ),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Weather',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                WeatherIcons.day_sunny,
                color: Colors.white,
              ),
              Icon(
                WeatherIcons.moon_alt_waning_crescent_4,
                color: Colors.white,
              ),
              Icon(
                WeatherIcons.cloudy,
                color: Colors.white,
              ),
              Icon(
                WeatherIcons.strong_wind,
                color: Colors.white,
              ),
              Icon(
                WeatherIcons.showers,
                color: Colors.white,
              ),
              Icon(
                WeatherIcons.thunderstorm,
                color: Colors.white,
              ),
              Icon(WeatherIcons.snow, color: Colors.white),
              // Icon(
              //   WeatherIcons.day_sunny,
              //   color: Colors.white,
              // ),
              // Icon(
              //   WeatherIcons.day_cloudy,
              //   color: Colors.white,
              // ),
              // Icon(
              //   WeatherIcons.day_cloudy_windy,
              //   color: Colors.white,
              // ),
              // Icon(
              //   WeatherIcons.day_sunny,
              //   color: Colors.white,
              // ),
              // Icon(
              //   WeatherIcons.day_hail,
              //   color: Colors.white,
              // ),
              // Icon(
              //   WeatherIcons.day_rain,
              //   color: Colors.white,
              // ),
              // Icon(WeatherIcons.day_sunny, color: Colors.white),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < 7; i++)
                // _buildIconButton(widget.check_circle_selected[i], Colors.green),
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.check_circle_outline,
                        // size: 30,
                        color: widget.check_circle_selected[i] == false
                            ? Colors.white.withOpacity(0.5)
                            : Colors.green),
                    onPressed: () {
                      setState(() {
                        widget.check_circle_selected[i] = true;
                        widget.close_selected[i] = false;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 7; i++)
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.close,
                        // size: 30,
                        color: widget.close_selected[i] == false
                            ? Colors.white.withOpacity(0.5)
                            : Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.close_selected[i] = true;
                        widget.check_circle_selected[i] = false;
                      });
                    },
                  ),
                ),
              // Icon(Icons.close, size: 30),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Colors.white.withOpacity(0.5)),
              ),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Temperature',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Min",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text("Max",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: _buildTemperatureSlider(),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Colors.white.withOpacity(0.5)),
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((widget._currentRangeValues.start - 40).toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text((widget._currentRangeValues.end - 40).toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xff4ad7d9),
                onSurface: Colors.white.withOpacity(.5)),
            onPressed:
                (selectedIcon == null || (activityNameController.text.isEmpty))
                    ? null
                    : () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) => HomePage()));
                        Provider.of<ActivityProvider>(context, listen: false)
                            .addCreatedActivity(Activity(
                                activity: activityNameController.text,
                                activityIcon: selectedIcon,
                                condition: setActivityConditions(),
                                status: false));
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Activity Added",
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        );
                      },
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }

  Condition setActivityConditions() {
    var status = widget.check_circle_selected;
    Condition condition = Condition(
        temperatures: widget._currentRangeValues,
        isSunnyIdeal: status[0],
        isNightIdeal: status[1],
        isCloudyIdeal: status[2],
        isWindyIdeal: status[3],
        isRainyIdeal: status[4],
        isThunderstormIdeal: status[5],
        isSnowIdeal: status[6]);

    return condition;
  }

  TextEditingController activityNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    activityNameController.dispose();
  }

  final List _activityIcon1 = const [
    Icons.directions_run,
    Icons.sports_football,
    Icons.sports_basketball,
    Icons.sports_cricket,
    Icons.sports_golf,
  ];
  final List _activityIcon2 = const [
    Icons.sports_hockey,
    Icons.sports_handball,
    Icons.sports_kabaddi,
    Icons.sports_mma,
    Icons.sports_soccer,
  ];

  List<Widget> _activityRow1(List activityIcons) {
    List<Widget> widgets = [];
    for (int i = 0; i < activityIcons.length; i++) {
      widgets.add(_activityCard1(activityIcons[i], i));
    }

    return widgets;
  }

  List<Widget> _activityRow2(List activityIcons) {
    List<Widget> widgets = [];
    for (int i = 0; i < activityIcons.length; i++) {
      widgets.add(_activityCard2(activityIcons[i], i));
    }

    return widgets;
  }

  late MediaQueryData _mediaQueryData;
  late double screenWidth;
  late double screenHeight;

  Widget _activityCard1(var icon, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          icon1_selected[index] = !icon1_selected[index];
          if (icon1_selected[index]) {
            selectedIcon = _activityIcon1[index];
          } else {
            selectedIcon = null;
          }

          for (int i = 0; i < icon1_selected.length; i++) {
            icon2_selected[i] = false;
            if (i != index) {
              icon1_selected[i] = false;
            }
          }
        });
      },
      icon: Icon(icon,
          color: (icon1_selected[index])
              ? Color(0xff010e33)
              : Colors.black.withOpacity(.5)),
    );
  }

  Widget _activityCard2(var icon, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          icon2_selected[index] = !icon2_selected[index];
          if (icon2_selected[index]) {
            selectedIcon = _activityIcon2[index];
          } else {
            selectedIcon = null;
          }

          for (int i = 0; i < icon2_selected.length; i++) {
            icon1_selected[i] = false;
            if (i != index) {
              icon2_selected[i] = false;
            }
          }
        });
      },
      icon: Icon(icon,
          color: (icon2_selected[index])
              ? Color(0xff010e33)
              : Colors.black.withOpacity(.5)),
    );
  }

  RangeSlider _buildTemperatureSlider() {
    return RangeSlider(
      activeColor: Colors.white,
      values: widget._currentRangeValues,
      min: 0,
      max: 80,
      divisions: 80,
      labels: RangeLabels(
        widget.sliderLabel(widget._currentRangeValues.start.round()),
        widget.sliderLabel(widget._currentRangeValues.end.round()),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          widget._currentRangeValues = values;
        });
      },
    );
  }

  // IconButton _buildIconButton(bool isSelected, Color selectedColor) {
  //   return IconButton(
  //     icon: Icon(
  //       Icons.check_circle_outline,
  //       size: 30,
  //       color: isSelected == false ? Colors.black : Colors.green,
  //     ),
  //     onPressed: () {
  //       setState(() {
  //         isSelected = !isSelected;
  //       });
  //     },
  //   );
  // }
}
