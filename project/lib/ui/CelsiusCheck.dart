import 'package:flutter/material.dart';
import 'package:project/core/variables.dart';

class CelsiusCheck extends StatefulWidget{

  @override
  CelsiusCheckState createState() => CelsiusCheckState();
}

class CelsiusCheckState extends State<CelsiusCheck>{
  @override
  Widget build(BuildContext context){
    return Container(
      child: celsiusPressed? Icon(Icons.check) : Container(),
    );
  }
}