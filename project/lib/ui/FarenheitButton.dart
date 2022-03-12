import 'package:flutter/material.dart';
import 'package:project/core/variables.dart';

class FarenheitButton extends StatefulWidget{

  @override
  FarenheitButtonState createState() => FarenheitButtonState();
}

class FarenheitButtonState extends State<FarenheitButton>{

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        onPressed: () {
          celsiusPressed = false;
          farenheitPressed = true;
        },
        child: const Text(
          'Farenheit(°F)',
          style: TextStyle(
            color: Color(0xff262626),
          ),
          textAlign: TextAlign.left,
        ),
        style: ElevatedButton.styleFrom(
            primary: Color(0xffffffff)
        )
    );
  }
}