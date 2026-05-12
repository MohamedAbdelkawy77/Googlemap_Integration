import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/Core/const_translat.dart';
import 'package:googlemap/Core/utils/location_service.dart';
import 'package:googlemap/Features/Data/Models/place_model.dart';
import 'package:googlemap/Features/Data/Models/polygon_model.dart';
import 'package:location/location.dart';

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
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Location location = Location();
  late LocationService locationService = LocationService(location: location);

  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
        target: LatLng(29.223453944797, 30.890921638123807), zoom: 10);
    cameraTargetBounds = CameraTargetBounds(LatLngBounds(
        southwest: LatLng(28.669260565563302, 28.669260565563302),
        northeast: LatLng(30.781084246879495, 30.85925774374115)));
    initMarkes();
    initpolylines();
    initpolygons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            // polygons: polygons,
            // polylines: polylines,
            onMapCreated: (controller) {
              // very very important
              googleMapController = controller;
              initmapstyle();
              inituserLocation();
            },
            markers: markers,
            initialCameraPosition: cameraPosition,
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
                onPressed: () {}, child: Text(ConstTranslat.changepass.tr())),
          )
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

  void initpolylines() {
    Polyline polyline = Polyline(
        color: Colors.blue,
        width: 6,
        polylineId: PolylineId("1"),
        points: [
          LatLng(29.308874257231924, 30.842544291393864),
          LatLng(29.303485361529475, 30.82245991066934),
          LatLng(29.323392921115996, 30.871555063551508),
        ]);
    polylines.add(polyline);
  }

  void initpolygons() {
    Polygon polygon = Polygon(
        fillColor: Colors.blueAccent.withAlpha(50),
        strokeColor: Colors.cyan,
        strokeWidth: 4,
        polygonId: PolygonId("1"),
        points: pointspolygon,
        holes: [
          holepolygon1,
          holepolygon2,
          holepolygon3,
        ]);

    polygons.add(polygon);
  }

  void inituserLocation() async {
    await locationService.serverLocation();
    bool premission = await locationService.premessionLocation();
    if (premission) {
      locationService.getUserLocation().listen((streamlocation) {
        userPositionStream(streamlocation);
        addUsermarker(streamlocation);
      });
    } else {
      print("user decline the premession");
    }
  }

  void userPositionStream(LatLng streamlocation) {
        CameraPosition newcamera = CameraPosition(target: streamlocation);
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(newcamera));
  }

  void addUsermarker(LatLng streamlocation) {
       Marker userMarker = Marker(
      markerId: MarkerId("usermark"),
      position: streamlocation,
    );
    markers.add(userMarker);
    setState(() {});
  }
}
