// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  Location location;
  LocationService({
    required this.location,
  });
  Future<void> serverLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // erro bar not enable GPS in Phone
        return;
      }
    }
  }

  Future<bool> premessionLocation() async {
    PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.deniedForever) {
      return false;
    } else if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      return permissionGranted == PermissionStatus.granted;
    } else {
      return true;
    }
  }

  Stream<LatLng> getUserLocation() async* {
    location.changeSettings(distanceFilter: 3);
 
    await for (final locationData in location.onLocationChanged) {
      yield LatLng(
        locationData.latitude ?? 30.0,
        locationData.longitude ?? 29.0,
      );
    }
  }
}
