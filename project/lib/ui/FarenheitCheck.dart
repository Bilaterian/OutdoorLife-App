import 'package:flutter/material.dart';
import 'package:project/core/variables.dart';

class FarenheitCheck extends StatefulWidget{

  @override
  FarenheitCheckState createState() => FarenheitCheckState();
}

class FarenheitCheckState extends State<FarenheitCheck>{
  @override
  Widget build(BuildContext context){
    return Container(
      child: farenheitPressed? Icon(Icons.check) : Container(),
    );
  }
}