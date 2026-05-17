import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/Core/utils/location_service.dart';
import 'package:googlemap/Features/Presentation/Manager/prediction_places_cubit/prediction_places_cubit.dart';
import 'package:googlemap/Features/Presentation/Manager/prediction_places_cubit/prediction_places_state.dart';
import 'package:location/location.dart';

class Googlemapinfo extends StatefulWidget {
  const Googlemapinfo({super.key});

  @override
  State<Googlemapinfo> createState() => _GooglemapinfoState();
}

class _GooglemapinfoState extends State<Googlemapinfo> {
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionPlacesCubit, PredictionPlacesState>(
        builder: (context, state) {
      if (state is PlacesinfosStateFailur) {
        return Text(state.message, style: TextStyle(color: Colors.red));
      } else if (state is PlacesinfoStateSuccess) {
        return Stack(
          children: [
            GoogleMap(
                onMapCreated: (control) {
                  googleMapController = control;
                  googleMapController.animateCamera(
                      CameraUpdate.newLatLng(state.place.location));
                },
                initialCameraPosition: cameraPosition),
            Text(
              state.place.formattedAddress,
              style: TextStyle(color: Colors.indigo),
            )
          ],
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
