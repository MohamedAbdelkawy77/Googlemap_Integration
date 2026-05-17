import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:googlemap/Features/Data/DataSource/data_contract/data_contract.dart';
import 'package:googlemap/Features/Data/Models/place_details.dart';
import 'package:googlemap/Features/Data/Models/place_prediction_model.dart';
import 'package:googlemap/Features/Data/Models/server_error_model.dart';

class DataImplement implements DataContract {
  Dio dio = Dio();

  String apiKey = "AIzaSyDRiHN8C7_LQt8A-TqNTGY_juVBfmQeORM";
  @override
  Future<Either<ServerErrorModel, List<PlacePredictionModel>>> predictionplaces(
      String data) async {
    try {
      Response response =
          await dio.post("https://places.googleapis.com/v1/places:autocomplete",
              data: {"input": data},
              options: Options(headers: {
                "Content-Type": "application/json",
                "X-Goog-Api-Key": apiKey,
              }));

      List<dynamic> prplaces = response.data["suggestions"];
      List<PlacePredictionModel> places = [];
      places = prplaces
          .map((e) => PlacePredictionModel.fromJson(e["placePrediction"]))
          .toList();
      return right(places);
    } on DioException catch (e) {
      if (e.response != null) {
        ServerErrorModel serverErrorModel = ServerErrorModel.fromJson(
          data: e.response!.data,
        );

        return left(serverErrorModel);
      }

      return left(
        ServerErrorModel(message: "No internet connection", codeerror: 500),
      );
    }
  }

  Future<Either<ServerErrorModel, PlaceDetails>> placeinfo(String id) async {
    try {
      Response response =
          await dio.get("https://places.googleapis.com/v1/places/$id",
              options: Options(headers: {
                "Content-Type": "application/json",
                "X-Goog-Api-Key": apiKey,
                "X-Goog-FieldMask": "displayName,formattedAddress,location"
              }));

      PlaceDetails placeinfo = PlaceDetails.fromJson(data: response.data);

      return right(placeinfo);
    } on DioException catch (e) {
      if (e.response != null) {
        ServerErrorModel serverErrorModel = ServerErrorModel.fromJson(
          data: e.response!.data,
        );

        return left(serverErrorModel);
      }

      return left(
        ServerErrorModel(message: "No internet connection", codeerror: 500),
      );
    }
  }
}
