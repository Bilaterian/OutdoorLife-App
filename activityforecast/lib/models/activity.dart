import 'dart:ffi';

import 'package:flutter/material.dart';

final String tableActivities = 'activities';

final String tableActivities2 = 'activities2';

class ActivityFields {
  static final List<String> values = [
    id,
    activity,
    iconCodePoint,
    status,
    minTemp,
    maxTemp,
    isSunnyIdeal,
    isFogIdeal,
    isCloudyIdeal,
    isDrizzleIdeal,
    isRainyIdeal,
    isThunderstormIdeal,
    isSnowIdeal
  ];
  static final String id = '_id';
  static final String activity = 'activity';
  static final String iconCodePoint = 'iconCodePoint';
  static final String status = 'status';
  static final String minTemp = 'minTemp';
  static final String maxTemp = 'maxTemp';
  static final String isSunnyIdeal = 'isSunndyIdeal';
  static final String isFogIdeal = 'osFogIdeal';
  static final String isCloudyIdeal = 'isCloudyIdeal';
  static final String isDrizzleIdeal = 'isDrizzleIdeal';
  static final String isRainyIdeal = 'isRainyIdeal';
  static final String isThunderstormIdeal = 'isThunderstormIdeal';
  static final String isSnowIdeal = 'isSnowIdeal';
}

class Activity {
  int? id;
  String activity;
  IconData activityIcon;
  // RangeValues idealweather;
  bool status;
  // RangeValues temperatures;
  int minTemp;
  int maxTemp;
  bool isSunnyIdeal;
  bool isFogIdeal;
  bool isCloudyIdeal;
  bool isDrizzleIdeal;
  bool isRainyIdeal;
  bool isThunderstormIdeal;
  bool isSnowIdeal;

  Activity(
      {this.id,
      required this.activity,
      required this.activityIcon,
      // required this.idealweather,
      required this.status,
      // required this.temperatures,
      required this.minTemp,
      required this.maxTemp,
      required this.isSunnyIdeal,
      required this.isFogIdeal,
      required this.isCloudyIdeal,
      required this.isDrizzleIdeal,
      required this.isRainyIdeal,
      required this.isThunderstormIdeal,
      required this.isSnowIdeal});

  Activity copy(
          {int? id,
          String? activity,
          IconData? activityIcon,
          bool? status,
          // RangeValues? temperatures,
          int? minTemp,
          int? maxTemp,
          bool? isSunnyIdeal,
          bool? isFogIdeal,
          bool? isCloudyIdeal,
          bool? isDrizzleIdeal,
          bool? isRainyIdeal,
          bool? isThunderstormIdeal,
          bool? isSnowIdeal}) =>
      Activity(
          id: id ?? this.id,
          activity: activity ?? this.activity,
          activityIcon: activityIcon ?? this.activityIcon,
          status: status ?? this.status,
          minTemp: minTemp ?? this.minTemp,
          maxTemp: maxTemp ?? this.maxTemp,
          isSunnyIdeal: isSunnyIdeal ?? this.isSunnyIdeal,
          isFogIdeal: isFogIdeal ?? this.isFogIdeal,
          isCloudyIdeal: isCloudyIdeal ?? this.isCloudyIdeal,
          isDrizzleIdeal: isDrizzleIdeal ?? this.isDrizzleIdeal,
          isRainyIdeal: isRainyIdeal ?? this.isRainyIdeal,
          isThunderstormIdeal: isThunderstormIdeal ?? this.isThunderstormIdeal,
          isSnowIdeal: isSnowIdeal ?? this.isThunderstormIdeal);

  static Activity fromJson(Map<String, Object?> json) => Activity(
      id: json[ActivityFields.id] as int?,
      activity: json[ActivityFields.activity] as String,
      activityIcon: IconData(json[ActivityFields.iconCodePoint] as int,
          fontFamily: 'MaterialIcons'),
      status: json[ActivityFields.status] == 1,
      minTemp: json[ActivityFields.minTemp] as int,
      maxTemp: json[ActivityFields.maxTemp] as int,
      isSunnyIdeal: json[ActivityFields.isSunnyIdeal] == 1,
      isFogIdeal: json[ActivityFields.isFogIdeal] == 1,
      isCloudyIdeal: json[ActivityFields.isCloudyIdeal] == 1,
      isDrizzleIdeal: json[ActivityFields.isDrizzleIdeal] == 1,
      isRainyIdeal: json[ActivityFields.isRainyIdeal] == 1,
      isThunderstormIdeal: json[ActivityFields.isThunderstormIdeal] == 1,
      isSnowIdeal: json[ActivityFields.isSnowIdeal] == 1);

  Map<String, dynamic> toJson() => {
        ActivityFields.id: id,
        ActivityFields.activity: activity,
        ActivityFields.iconCodePoint: activityIcon.codePoint,
        ActivityFields.minTemp: minTemp,
        ActivityFields.maxTemp: maxTemp,
        ActivityFields.isSunnyIdeal: isSunnyIdeal ? 1 : 0,
        ActivityFields.isFogIdeal: isFogIdeal ? 1 : 0,
        ActivityFields.isCloudyIdeal: isCloudyIdeal ? 1 : 0,
        ActivityFields.isDrizzleIdeal: isDrizzleIdeal ? 1 : 0,
        ActivityFields.isRainyIdeal: isRainyIdeal ? 1 : 0,
        ActivityFields.isThunderstormIdeal: isThunderstormIdeal ? 1 : 0,
        ActivityFields.isSnowIdeal: isSnowIdeal ? 1 : 0,
      };

  static Activity clone(Activity activity) {
    Activity temp = Activity(
        id: activity.id,
        activity: activity.activity,
        activityIcon: activity.activityIcon,
        status: activity.status,
        minTemp: activity.minTemp,
        maxTemp: activity.maxTemp,
        isSunnyIdeal: activity.isSunnyIdeal,
        isFogIdeal: activity.isFogIdeal,
        isCloudyIdeal: activity.isCloudyIdeal,
        isDrizzleIdeal: activity.isDrizzleIdeal,
        isRainyIdeal: activity.isRainyIdeal,
        isThunderstormIdeal: activity.isThunderstormIdeal,
        isSnowIdeal: activity.isSnowIdeal,
    );

    return temp;
  }
}
