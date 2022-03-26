import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'geolocator_service.dart';

class LocationManagement with ChangeNotifier{
  final geoLocatorService = GeolocatorService();

  late Position currentLocation;


  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}