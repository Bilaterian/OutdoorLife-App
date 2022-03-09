import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class CreateNewActivityPage extends StatefulWidget {
  CreateNewActivityPage({Key? key}) : super(key: key);
  List<bool> check_circle_selected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.home, color: Colors.white),
        ),
        title: const Text("Create New Activity"),
      ),
      body: buildNewActivityDetails(context),
    );
  }

  Widget buildNewActivityDetails(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Name',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter the activity name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Icon',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.directions_run, size: 30),
              Icon(Icons.sports_football, size: 30),
              Icon(Icons.sports_basketball, size: 30),
              Icon(Icons.sports_cricket, size: 30),
              Icon(Icons.sports_golf, size: 30),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.sports_hockey, size: 30),
              Icon(Icons.sports_handball, size: 30),
              Icon(Icons.sports_kabaddi, size: 30),
              Icon(Icons.sports_mma, size: 30),
              Icon(Icons.sports_soccer, size: 30),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Colors.black.withOpacity(0.5)),
              ),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Weather',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(WeatherIcons.day_sunny, size: 30),
              Icon(WeatherIcons.day_cloudy, size: 30),
              Icon(WeatherIcons.day_cloudy_windy, size: 30),
              Icon(WeatherIcons.day_sunny, size: 30),
              Icon(WeatherIcons.day_hail, size: 30),
              Icon(WeatherIcons.day_rain, size: 30),
              Icon(WeatherIcons.day_sunny, size: 30),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 7; i++)
                // _buildIconButton(widget.check_circle_selected[i], Colors.green),
                IconButton(
                  icon: Icon(Icons.check_circle_outline,
                      size: 30,
                      color: widget.check_circle_selected[i] == false
                          ? Colors.black
                          : Colors.green),
                  onPressed: () {
                    setState(() {
                      widget.check_circle_selected[i] =
                          !widget.check_circle_selected[i];
                    });
                  },
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
                IconButton(
                  icon: Icon(Icons.close,
                      size: 30,
                      color: widget.close_selected[i] == false
                          ? Colors.black
                          : Colors.red),
                  onPressed: () {
                    setState(() {
                      widget.close_selected[i] = !widget.close_selected[i];
                    });
                  },
                ),
              // Icon(Icons.close, size: 30),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Colors.black.withOpacity(0.5)),
              ),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Temperature',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _buildTemperatureSlider(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }

  RangeSlider _buildTemperatureSlider() {
    return RangeSlider(
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
