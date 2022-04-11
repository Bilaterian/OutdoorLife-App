import 'package:activityforecast/models/temperature.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemperatureProvider extends ChangeNotifier{
  final List temp = [
    Temperature(
        temperatureSelect: false,
        max:  40.0,
        min: -40.0,
        invert: false,
        currMax: 27,
        currMin: 15,
        notifications: false,
        reset: false,
    ),
  ];

  void changeTempSelect(){
    temp[0].temperatureSelect = !(temp[0].temperatureSelect);
    if(temp[0].temperatureSelect == true){
      if(temp[0].currMax > 40.0){
        temp[0].currMax = 39.9;
      }
      else{
        temp[0].currMax = (temp[0].currMax - 32)/1.8;
      }
      temp[0].currMin = (temp[0].currMin - 32)/1.8;

      temp[0].max = 40.0;
      temp[0].min = -40.0;
    }
    else{
      temp[0].currMax = temp[0].currMax * 1.8 + 32;
      temp[0].currMin = temp[0].currMin * 1.8 + 32;

      temp[0].max = 104.0;
      temp[0].min = -40.0;
    }

    notifyListeners();
  }

  void invertTempRange(){
    temp[0].invert = !(temp[0].invert);

    notifyListeners();
  }

  void setCurrMax(double newMax){
    temp[0].currMax = newMax;

    notifyListeners();
  }

  void setCurrMin(double newMin){
    temp[0].currMin = newMin;

    notifyListeners();
  }

  bool getTemperatureSelect(){
    return temp[0].temperatureSelect;
  }

  double getMax(){
    return temp[0].max;
  }

  double getMin(){
    return temp[0].min;
  }

  double getCurrMax(){
   return temp[0].currMax;
  }

  double getCurrMin(){
    return temp[0].currMin;
  }

  bool getInvert(){
    return temp[0].invert;
  }

  void switchNotifications(){
    temp[0].notifications = !(temp[0].notifications);

    notifyListeners();
  }

  bool getNotifications(){
    return temp[0].notifications;
  }

  void setUnit(bool unit){
    temp[0].temperatureSelect = unit;

    notifyListeners();
  }

  void setNotif(bool notif){
    temp[0].notifications = notif;

    notifyListeners();
  }

  void resetTemp(){
    temp[0].temperatureSelect = false;
    temp[0].max = 40.0;
    temp[0].min = -40.0;
    temp[0].invert = false;
    temp[0].currMax = 27;
    temp[0].currMin = 15;
    temp[0].notifications = false;
    temp[0].reset = false;
  }
}