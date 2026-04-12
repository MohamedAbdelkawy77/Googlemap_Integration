import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// map Id =16007166866186782288
class Googlemapwidget extends StatefulWidget {
  const Googlemapwidget({super.key});

  @override
  State<Googlemapwidget> createState() => _GooglemapwidgetState();
}

class _GooglemapwidgetState extends State<Googlemapwidget> {
  late CameraPosition cameraPosition;
  late CameraTargetBounds cameraTargetBounds;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            //cloudMapId: "7b45f98a05a8f360886451de",
            onMapCreated: (controller) {
              // very very important
              googleMapController = controller;
              initmapstyle();
            },
            markers: markers,
            initialCameraPosition: cameraPosition,
            cameraTargetBounds: cameraTargetBounds,
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
                onPressed: () {
                  googleMapController.animateCamera(CameraUpdate.newLatLng(
                      LatLng(29.144246329039845, 30.7768241879684)));
                },
                child: Text("Change Location ")),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
        target: LatLng(29.320185448120004, 30.834018834471525), zoom: 10);
    cameraTargetBounds = CameraTargetBounds(LatLngBounds(
        southwest: LatLng(29.259226706515292, 30.74275868096059),
        northeast: LatLng(29.328088816630828, 30.895047338474143)));
    initMarkes();
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  void initmapstyle() async {
    var mapstyle = await DefaultAssetBundle.of(context)
        .loadString("assets/Map_Styles/night_map.Json");
    googleMapController.setMapStyle(mapstyle);
  }

  void initMarkes() {
    var mark1 = Marker(
        markerId: MarkerId("1"),
        position: LatLng(29.320185448120004, 30.834018834471525));
    var mark2 = Marker(
        markerId: MarkerId("2"),
        position: LatLng(29.309805653261304, 30.843709785819456));
    markers.add(mark1);
    markers.add(mark2);
  }
}
