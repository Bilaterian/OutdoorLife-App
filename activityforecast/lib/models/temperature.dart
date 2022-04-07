import 'package:flutter/material.dart';

class Temperature{
  bool temperatureSelect; //false = celsius, true = fahrenheit
  double min;
  double max;
  bool invert; //false = inclusive, true = exclusive
  double currMax;
  double currMin;
  bool notifications;

  Temperature({
    required this.temperatureSelect,
    required this.min,
    required this.max,
    required this.invert,
    required this.currMax,
    required this.currMin,
    required this.notifications,
  });


}