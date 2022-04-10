import 'package:flutter/material.dart';

class Condition {
  RangeValues temperatures;
  bool isSunnyIdeal;
  bool isFogIdeal;
  bool isCloudyIdeal;
  bool isDrizzleIdeal;
  bool isRainyIdeal;
  bool isThunderstormIdeal;
  bool isSnowIdeal;

  Condition(
      {required this.temperatures,
      required this.isSunnyIdeal,
      required this.isFogIdeal,
      required this.isCloudyIdeal,
      required this.isDrizzleIdeal,
      required this.isRainyIdeal,
      required this.isThunderstormIdeal,
      required this.isSnowIdeal});
}
