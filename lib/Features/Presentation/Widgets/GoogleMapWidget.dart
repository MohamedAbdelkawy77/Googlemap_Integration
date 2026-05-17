import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/Core/const_translat.dart';
import 'package:googlemap/Core/utils/location_service.dart';
import 'package:googlemap/Features/Data/Models/place_model.dart';
import 'package:googlemap/Features/Presentation/Manager/prediction_places_cubit/prediction_places_cubit.dart';
import 'package:googlemap/Features/Presentation/Widgets/search_place.dart';
import 'package:location/location.dart';

class Googlemapwidget extends StatefulWidget {
  const Googlemapwidget({super.key});

  @override
  State<Googlemapwidget> createState() => _GooglemapwidgetState();
}

class _GooglemapwidgetState extends State<Googlemapwidget> {
  late CameraPosition cameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Location location = Location();
  late LocationService locationService = LocationService(location: location);

  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
        target: LatLng(29.223453944797, 30.890921638123807), zoom: 10);

    //initMarkes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              // very very important
              googleMapController = controller;
              initmapstyle();
              getusercurrentLocation();
              //inituserLocation();
            },
            markers: markers,
            initialCameraPosition: cameraPosition,
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
                onPressed: () {}, child: Text(ConstTranslat.changepass.tr())),
          ),
          SearchPlace(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  void initmapstyle() async {
    var mapstyle = await DefaultAssetBundle.of(context)
        .loadString("assets/Map_Styles/night_map.Json");
    googleMapController.setMapStyle(mapstyle);
  }

  void initMarkes() async {
    var customicon = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(30, 30)), places[0].image);
    var mrs = places.map((place) => Marker(
        icon: customicon,
        infoWindow: InfoWindow(
          title: place.name,
        ),
        markerId: MarkerId(place.id.toString()),
        position: place.latLng));
    markers.addAll(mrs);

    setState(() {});
  }

  void inituserLocation() async {
    locationService.getUserLocationstream().listen((streamlocation) {
      userPositionStream(streamlocation);
      addUsermarker(streamlocation);
    });
  }

  void userPositionStream(LatLng streamlocation) {
    CameraPosition newcamera = CameraPosition(target: streamlocation, zoom: 15);
    // googleMapController
    //     .animateCamera(CameraUpdate.newCameraPosition(newcamera));

    googleMapController.animateCamera(CameraUpdate.newLatLng(streamlocation));
  }

  void addUsermarker(LatLng streamlocation) async {
    var customicon = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(30, 30)), places[0].image);
    Marker userMarker = Marker(
      icon: customicon,
      markerId: MarkerId("usermark"),
      position: streamlocation,
    );

    setState(() {
      markers.add(userMarker);
    });
  }

  void getusercurrentLocation() async {
    try {
      var currentlocation = await locationService.getUserLocation();
      LatLng userlocation =
          LatLng(currentlocation.latitude!, currentlocation.longitude!);
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: userlocation, zoom: 12)));
      Marker usermarker = Marker(
          markerId: MarkerId(
            "usermarker",
          ),
          position: userlocation);
      markers.add(usermarker);
      setState(() {});
    } on ExceptionserverEnable catch (e) {
    } on ExceptionPermissionStatus catch (e) {}
  }
}
