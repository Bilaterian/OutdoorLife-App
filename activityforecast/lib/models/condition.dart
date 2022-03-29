import 'package:flutter/material.dart';

class Condition {
  RangeValues temperatures;
  bool isSunnyIdeal;
  bool isNightIdeal;
  bool isCloudyIdeal;
  bool isWindyIdeal;
  bool isRainyIdeal;
  bool isThunderstormIdeal;
  bool isSnowIdeal;

  Condition(
      {required this.temperatures,
      required this.isSunnyIdeal,
      required this.isNightIdeal,
      required this.isCloudyIdeal,
      required this.isWindyIdeal,
      required this.isRainyIdeal,
      required this.isThunderstormIdeal,
      required this.isSnowIdeal});
}
