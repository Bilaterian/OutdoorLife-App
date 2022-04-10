import 'package:flutter/material.dart';

class Activity {
  String activity;
  IconData activityIcon;
  // RangeValues idealweather;
  bool status;
  RangeValues temperatures;
  bool isSunnyIdeal;
  bool isFogIdeal;
  bool isCloudyIdeal;
  bool isDrizzleIdeal;
  bool isRainyIdeal;
  bool isThunderstormIdeal;
  bool isSnowIdeal;

  Activity(
      {required this.activity,
      required this.activityIcon,
      // required this.idealweather,
      required this.status,
      required this.temperatures,
      required this.isSunnyIdeal,
      required this.isFogIdeal,
      required this.isCloudyIdeal,
      required this.isDrizzleIdeal,
      required this.isRainyIdeal,
      required this.isThunderstormIdeal,
      required this.isSnowIdeal});
  factory Activity.clone(Activity source) {
    return Activity(
        activity: source.activity,
        activityIcon: source.activityIcon,
        status: source.status,
        temperatures: source.temperatures,
        isSunnyIdeal: source.isSunnyIdeal,
        isFogIdeal: source.isDrizzleIdeal,
        isCloudyIdeal: source.isCloudyIdeal,
        isDrizzleIdeal: source.isDrizzleIdeal,
        isRainyIdeal: source.isRainyIdeal,
        isSnowIdeal: source.isSnowIdeal,
        isThunderstormIdeal: source.isThunderstormIdeal);
  }
}
