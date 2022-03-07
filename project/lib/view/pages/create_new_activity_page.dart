import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class CreateNewActivityPage extends StatefulWidget {
  const CreateNewActivityPage({Key? key}) : super(key: key);
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
      body: buildNewActivityDetails(),
    );
  }
}

Widget buildNewActivityDetails() {
  RangeValues _currentRangeValues = const RangeValues(0, 40);
  List<int> check_circle_selected = [0, 0, 0, 0, 0, 0, 0];
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
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
          child: Align(
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
          children: [
            Icon(Icons.directions_run, size: 30),
            Icon(Icons.sports_football, size: 30),
            Icon(Icons.sports_basketball, size: 30),
            Icon(Icons.sports_cricket, size: 30),
            Icon(Icons.sports_golf, size: 30),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
              bottom:
                  BorderSide(width: 1.0, color: Colors.black.withOpacity(0.5)),
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Weather',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < 7; i++)
              IconButton(
                icon: Icon(Icons.check_circle_outline,
                    size: 30,
                    color: check_circle_selected[i] == 0
                        ? Colors.black
                        : Colors.green),
                onPressed: () {
                  setState(() {
                    check_circle_selected[i] = 1;
                    print("Monica");
                  });
                },
              ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < 7; i++) Icon(Icons.close, size: 30),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom:
                  BorderSide(width: 1.0, color: Colors.black.withOpacity(0.5)),
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Temperature',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Save'),
        ),
      ),
      Expanded(
        child: RangeSlider(
            values: _currentRangeValues,
            max: 100,
            divisions: 5,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            }),
      ),
    ],
  );
}

void setState(Null Function() param0) {}

// Widget buildIconButton(List selected) {
//   return IconButton(
//     icon: Icon(Icons.check_circle_outline,
//         size: 30,
//         color: check_circle_selected[i] == 0 ? Colors.black : Colors.green),
//     onPressed: () {
//       setState(() {
//         check_circle_selected[i] = 1;
//         print("Monica");
//       });
//     },
//   );
// }
