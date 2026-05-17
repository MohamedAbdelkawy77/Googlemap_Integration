import 'package:googlemap/Features/Data/Models/place_details.dart';
import 'package:googlemap/Features/Data/Models/place_prediction_model.dart';

abstract class PredictionPlacesState {}

class PredictionPlacesStateSuccess extends PredictionPlacesState {
  final List<PlacePredictionModel> places;

  PredictionPlacesStateSuccess({required this.places});
}

class PredictionPlacesStateFailur extends PredictionPlacesState {
  final String message;

  PredictionPlacesStateFailur({required this.message});
}

class PredictionPlacesStateLoading extends PredictionPlacesState {}


class PlacesinfoStateSuccess extends PredictionPlacesState {
  final PlaceDetails place;

  PlacesinfoStateSuccess({required this.place});
}

class PlacesinfosStateFailur extends PredictionPlacesState {
  final String message;

  PlacesinfosStateFailur({required this.message});
}

class PlacesinfoStateLoading extends PredictionPlacesState {}