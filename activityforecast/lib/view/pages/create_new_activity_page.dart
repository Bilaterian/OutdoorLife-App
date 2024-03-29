import 'package:activityforecast/components/icons.dart';
import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:activityforecast/components/themes/themes.dart';
import 'package:activityforecast/components/weather_icons.dart';
import 'package:activityforecast/models/activity.dart';
import 'package:activityforecast/models/activity_provider.dart';
import 'package:activityforecast/models/theme.dart';
import 'package:activityforecast/models/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:activityforecast/view/pages/home_page.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../services/activities_database.dart';

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
  // final Color? backgroundColor = firstTheme["quaternary"];
  // final Color? textColor = firstTheme["primary"];
  // final Color? appBarColor = firstTheme["primary"];
  // final Color? appBarTextColor = firstTheme["quaternary"];
  // final Color? tabBarColor = (firstTheme["secondary"] as Color).withOpacity(.5);
  // final Color? unselectedactivityIconColor = firstTheme["quaternary"];
  // final Color? selectedactivityIconColor = firstTheme["primary"];
  // final Color? weatherColor = firstTheme["primary"];

  late Color? backgroundColor;
  late Color? textColor;
  late Color? appBarColor;
  late Color? appBarTextColor;
  late Color? tabBarColor;
  late Color? unselectedactivityIconColor;
  late Color? selectedactivityIconColor;
  late Color? weatherColor;
}

class _CreateNewActivityPageState extends State<CreateNewActivityPage> {
  late ColourScheme theme;
  int selectedActivity = -1;
  List<bool> icon1_selected = [false, false, false, false, false];
  List<bool> icon2_selected = [false, false, false, false, false];
  var selectedIcon;
  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context).currentTheme;
    widget.backgroundColor = theme.secondary;
    widget.textColor = theme.quaternary;
    widget.appBarColor = theme.primary;
    widget.appBarTextColor = theme.secondary;
    widget.tabBarColor = theme.quinary.withOpacity(.5);
    widget.unselectedactivityIconColor = theme.secondary;
    widget.selectedactivityIconColor = theme.quaternary;
    widget.weatherColor = theme.primary;
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
          title: Text('Create New Activity',
              style: TextStyle(color: widget.appBarTextColor)),
          backgroundColor: widget.appBarColor,
          actions: [
            IconButton(
              onPressed: () {
                //Navigator.of(context)
                //    .push(MaterialPageRoute(builder: (context) => HomePage()));

                //Navigator.pop(context, false);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: Icon(Icons.home, color: widget.appBarTextColor),
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
          ),
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: widget.textColor as Color,
                ),
              )),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 20, color: widget.textColor),
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
            style: TextStyle(color: widget.textColor),
            decoration: InputDecoration(
              fillColor: widget.textColor,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.textColor as Color)),
              labelText: 'Enter the activity name',
              labelStyle: TextStyle(color: widget.textColor),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: widget.textColor as Color,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Icons',
                style: TextStyle(fontSize: 20, color: widget.textColor),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            color: widget.tabBarColor,
            child: DefaultTabController(
              length: activityTabIcons.length,
              child: Column(
                children: [
                  TabBar(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      indicatorWeight: 5,
                      labelColor: widget.appBarTextColor,
                      indicatorColor: widget.appBarColor,
                      tabs: [
                        for (var icon in activityTabIcons.values)
                          Tab(
                              icon: Icon(
                            icon,
                            color: widget.appBarColor,
                          )),
                      ]),
                  SizedBox(
                    height: screenHeight / 3,
                    child: Material(
                      color: widget.tabBarColor,
                      child: TabBarView(
                        children: [
                          for (int i = 0; i < activityIcons.length; i++)
                            gridViewIcon(activityIcons.values.elementAt(i), i),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(width: 1.0, color: widget.textColor as Color),
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Weather',
                style:
                    TextStyle(fontSize: 20, color: widget.textColor as Color),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var weatherIcon in weatherIcons.values)
                Icon(
                  weatherIcon,
                  color: widget.weatherColor,
                )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < widget.check_circle_selected.length; i++)
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.check_circle_outline,
                        // size: 30,
                        color: widget.check_circle_selected[i] == false
                            ? (widget.appBarColor as Color).withOpacity(.5)
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
              for (int i = 0; i < widget.close_selected.length; i++)
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.close,
                        color: widget.close_selected[i] == false
                            ? (widget.appBarColor as Color).withOpacity(.5)
                            : Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.close_selected[i] = true;
                        widget.check_circle_selected[i] = false;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(width: 1.0, color: widget.textColor as Color),
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Temperature',
                style: TextStyle(fontSize: 20, color: widget.textColor),
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
                        style:
                            TextStyle(fontSize: 20, color: widget.textColor)),
                    Text("Max",
                        style:
                            TextStyle(fontSize: 20, color: widget.textColor)),
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
                bottom:
                    BorderSide(width: 1.0, color: widget.textColor as Color),
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
                        style:
                            TextStyle(fontSize: 20, color: widget.textColor)),
                    Text((widget._currentRangeValues.end - 40).toString(),
                        style:
                            TextStyle(fontSize: 20, color: widget.textColor)),
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
                primary: widget.appBarColor,
                onSurface: (widget.appBarColor as Color).withOpacity(.5)),
            onPressed: // if an activity icon has not been selected the did not enter an activity name, the save button must be disabled
                (selectedIcon == null || (activityNameController.text.isEmpty))
                    ? null
                    : () {
                        Activity activity = Activity(
                            activity: activityNameController.text,
                            activityIcon: selectedIcon,
                            minTemp: widget._currentRangeValues.start.toInt(),
                            maxTemp: widget._currentRangeValues.end.toInt(),
                            isSunnyIdeal: widget.check_circle_selected[0],
                            isFogIdeal: widget.check_circle_selected[1],
                            isCloudyIdeal: widget.check_circle_selected[2],
                            isDrizzleIdeal: widget.check_circle_selected[3],
                            isRainyIdeal: widget.check_circle_selected[4],
                            isThunderstormIdeal:
                                widget.check_circle_selected[5],
                            isSnowIdeal: widget.check_circle_selected[6],
                            status: false);

                        Provider.of<ActivityProvider>(context, listen: false)
                            .addCreatedActivity(activity);
                        ActivitiesDatabase.instance.create2(activity);
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Activity Added",
                              style: TextStyle(color: widget.appBarColor),
                            ),
                            backgroundColor: widget.appBarTextColor,
                          ),
                        );
                      },
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }

  // final ScrollController _controllerOne = ScrollController();
  List<ScrollController> controllers =
      List.generate(6, (i) => ScrollController());

  Scrollbar gridViewIcon(List<IconData> icons, int tabIndex) {
    return Scrollbar(
      controller: controllers[tabIndex],
      isAlwaysShown: true,
      child: GridView(
          controller: controllers[tabIndex],
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            mainAxisExtent: 50,
          ),
          children: [..._activityTab(icons, tabIndex)]),
    );
  }

  TextEditingController activityNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    activityNameController.dispose();
  }

  List<Widget> _activityTab(List icons, int tabIndex) {
    List<Widget> widgets = [];

    for (int i = 0; i < icons.length; i++) {
      widgets.add(_activityTabSelection(icons[i], i, tabIndex));
    }
    return widgets;
  }

  Map<int, int> selectedIconIndex = {};

  Widget _activityTabSelection(var icon, int index, int tabIndex) {
    return IconButton(
      onPressed: () {
        setState(() {
          if (selectedIconIndex.isEmpty) {
            selectedIconIndex.putIfAbsent(tabIndex, () => index);
            selectedIcon = icon;
          } else {
            if (!(selectedIconIndex.containsKey(tabIndex) &&
                selectedIconIndex.containsValue(index))) {
              selectedIconIndex.clear();
              selectedIconIndex.putIfAbsent(tabIndex, () => index);
              selectedIcon = icon;
            }
          }
        });
      },
      icon: Icon(icon,
          color: ((selectedIconIndex.containsKey(tabIndex) &&
                  selectedIconIndex.containsValue(index)))
              // ? Color(0xff031342)
              ? widget.selectedactivityIconColor
              : widget.unselectedactivityIconColor),
    );
  }

  late MediaQueryData _mediaQueryData;
  late double screenWidth;
  late double screenHeight;

  RangeSlider _buildTemperatureSlider() {
    return RangeSlider(
      activeColor: widget.appBarColor,
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
}
