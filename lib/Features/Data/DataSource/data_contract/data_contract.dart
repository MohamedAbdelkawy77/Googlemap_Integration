import 'package:dartz/dartz.dart';
import 'package:googlemap/Features/Data/Models/place_details.dart';
import 'package:googlemap/Features/Data/Models/place_prediction_model.dart';
import 'package:googlemap/Features/Data/Models/server_error_model.dart';

abstract class DataContract {
  Future<Either<ServerErrorModel, List<PlacePredictionModel>>> predictionplaces(
      String data);
  Future<Either<ServerErrorModel, PlaceDetails>> placeinfo(String id);
}
