import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
 
  final int id;
  final String name;
  final LatLng latLng;
  final String image;
  PlaceModel(
      {required this.id,
      required this.name,
      required this.latLng,
      required this.image});
}

List<PlaceModel> places = [
  PlaceModel(
      id: 1,
      name: "New Fayoum",
      latLng: LatLng(29.223453944797, 30.890921638123807),
      image: "assets/images/LogoIcons.png"),
  PlaceModel(
      id: 2,
      name: "New Fayoum Collage",
      latLng: LatLng(29.21362726982885, 30.909542715083166),
      image: "assets/images/LogoIcons.png"),
  PlaceModel(
      id: 3,
      name: "Fayoum Bank",
      latLng: LatLng(29.230382443902457, 30.899005206582395),
      image: "assets/images/LogoIcons.png"),
];
