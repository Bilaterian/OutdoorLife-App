import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'location_management.dart';

class MapDisplay extends StatefulWidget{

  @override
  MapDisplayState createState() => MapDisplayState();
}

class MapDisplayState extends State<MapDisplay> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    final locationManagement = Provider.of<LocationManagement>(context);
    return Expanded(
      child: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: (locationManagement.currentLocation == null)? LatLng(0, 0)
                : LatLng(locationManagement.currentLocation.latitude, locationManagement.currentLocation.longitude),
            zoom: 14,
          ),
          myLocationEnabled: true,
        ),
      ),
    );
  }
}