import 'package:activityforecast/models/Condition.dart';
import 'package:flutter/material.dart';

class Activity {
  String activity;
  IconData activityIcon;
  // RangeValues idealweather;
  bool status;
  Condition condition;
  bool notification = true;

  Activity({
    required this.activity,
    required this.activityIcon,
    // required this.idealweather,
    required this.status,
    required this.condition,
    notification = true,
  });
}
