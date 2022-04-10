import 'package:flutter/material.dart';

class Activity {
  int order;
  int category;
  String activity;
  int activityIconCP;
  // RangeValues idealweather;
  //RangeValues temperatures;
  int minTemp;
  int maxTemp;
  bool isSunnyIdeal;
  bool isFogIdeal;
  bool isCloudyIdeal;
  bool isDrizzleIdeal;
  bool isRainyIdeal;
  bool isThunderstormIdeal;
  bool isSnowIdeal;

  Activity({
    required this.order,
    required this.category,
    required this.activity,
    required this.activityIconCP,
    // required this.idealweather,
    //required this.temperatures,
    required this.minTemp,
    required this.maxTemp,
    required this.isSunnyIdeal,
    required this.isFogIdeal,
    required this.isCloudyIdeal,
    required this.isDrizzleIdeal,
    required this.isRainyIdeal,
    required this.isThunderstormIdeal,
    required this.isSnowIdeal
  });

  Map<String, dynamic> toMap() {
    return {
      'ord': this.order,
      'category': this.category,
      'name': this.activity,
      'icon': this.activityIconCP,
      'minTemp': this.minTemp,
      'maxTemp': this.maxTemp,
      'sunny': this.isSunnyIdeal ? 1 : 0,
      'fog': this.isFogIdeal ? 1 : 0,
      'cloudy': this.isCloudyIdeal ? 1 : 0,
      'drizzle': this.isDrizzleIdeal ? 1 : 0,
      'rainy': this.isRainyIdeal ? 1 : 0,
      'thunderstorm': this.isThunderstormIdeal ? 1 : 0,
      'snow': this.isSnowIdeal ? 1 : 0,
    };
  }
}
