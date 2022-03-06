import 'package:flutter/material.dart';
import 'package:project/core/SettingsPage.dart';

class SettingsButton extends StatefulWidget{
  const SettingsButton({Key? key}) : super(key: key);

  @override
  SettingsButtonState createState() => SettingsButtonState();
}
class SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SettingsPage(), //send to add attraction page
          ),
        );
      },
    );
  }
}