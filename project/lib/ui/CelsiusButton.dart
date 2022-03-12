import 'package:flutter/material.dart';
import 'package:project/core/variables.dart';

class CelsiusButton extends StatefulWidget{

  @override
  CelsiusButtonState createState() => CelsiusButtonState();
}

class CelsiusButtonState extends State<CelsiusButton>{

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        onPressed: () {
          celsiusPressed = true;
          farenheitPressed = false;
        },
        child: const Text(
          'Celsius(°C)',
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