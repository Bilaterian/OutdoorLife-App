import 'package:flutter/material.dart';

class TemperatureProvider extends ChangeNotifier{
  bool temperatureSelect = false;

  void changeTemperatureUnit(){

    temperatureSelect = !temperatureSelect;

    notifyListeners();
  }
}