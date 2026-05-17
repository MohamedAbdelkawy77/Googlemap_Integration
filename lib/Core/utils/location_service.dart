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
        throw ExceptionserverEnable();
      }
    }
  }

  Future<void> premessionLocation() async {
    PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.deniedForever) {
      throw ExceptionPermissionStatus();
    } else if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw ExceptionPermissionStatus();
      }
    }
  }

  Stream<LatLng> getUserLocationstream() async* {
    await serverLocation();
    await premessionLocation();
    location.changeSettings(
      distanceFilter: 3,
    );

    await for (final locationData in location.onLocationChanged) {
      yield LatLng(
        locationData.latitude ?? 30.0,
        locationData.longitude ?? 29.0,
      );
    }
  }

  Future<LocationData> getUserLocation() async {
    await serverLocation();
    await premessionLocation();
    return await location.getLocation();
  }
}

class ExceptionserverEnable implements Exception {}

class ExceptionPermissionStatus implements Exception {}
