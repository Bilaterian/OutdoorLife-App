import 'package:flutter/material.dart';
import 'package:project/core/variables.dart';

class ResetButton extends StatefulWidget{

  @override
  ResetButtonState createState() => ResetButtonState();
}

class ResetButtonState extends State<ResetButton>{

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        onPressed: () {
          celsiusPressed = true;
          farenheitPressed = false;
        },
        child: const Text(
            'Reset',
            style: TextStyle(
              color: Color(0xffffffff),
            )
        ),
        style: ElevatedButton.styleFrom(
            primary: Color(0xff262626)
        )
    );
  }
}