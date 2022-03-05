import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/core/locations.dart' as locations;

class MapDisplay extends StatefulWidget{
  LatLng centerMap = LatLng(45.521563, -122.677433);

  @override
  MapDisplayState createState() => MapDisplayState();
}

class MapDisplayState extends State<MapDisplay> {
  late GoogleMapController mapController;
  final Map<String, Marker> markers = {};

  Future<void> onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
          //markers: markers.values.toSet(),
          myLocationEnabled: true,
        ),
      ),
    );
  }
}