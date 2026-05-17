import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDetails {
  final String formattedAddress;
  final LatLng location;

  PlaceDetails({required this.formattedAddress, required this.location});

  factory PlaceDetails.fromJson({required Map<String, dynamic> data}) {
    return PlaceDetails(
        formattedAddress: data["formattedAddress"],
        location: LatLng(
            data["location"]["latitude"], data["location"]["longitude"]));
  }
}
