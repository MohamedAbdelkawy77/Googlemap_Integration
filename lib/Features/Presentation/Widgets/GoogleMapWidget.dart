import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/Core/const_translat.dart';
import 'package:googlemap/Features/Data/Models/place_model.dart';
import 'package:googlemap/Features/Data/Models/polygon_model.dart';

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
  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
        target: LatLng(29.223453944797, 30.890921638123807), zoom: 10);
    cameraTargetBounds = CameraTargetBounds(LatLngBounds(
        southwest: LatLng(29.302590281256727, 30.85925774374115),
        northeast: LatLng(30.781084246879495, 28.669260565563302)));
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
            polygons: polygons,
            polylines: polylines,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              // very very important
              googleMapController = controller;
              initmapstyle();
            },
            markers: markers,
            initialCameraPosition: cameraPosition,
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
                onPressed: () {
                  googleMapController.animateCamera(CameraUpdate.newLatLng(
                      LatLng(29.21362726982885, 30.909542715083166)));
                  context.setLocale(Locale("ar"));
                },
                child: Text(ConstTranslat.changepass.tr())),
          )
        ],
      ),
    );
  }
 
  void initmapstyle() async {
    var mapstyle = await DefaultAssetBundle.of(context)
        .loadString("assets/Map_Styles/night_map.Json");
    googleMapController.setMapStyle(mapstyle);
  }

  void initMarkes() async {
    var customicon = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(30, 30)), places[1].image);
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

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }
}
