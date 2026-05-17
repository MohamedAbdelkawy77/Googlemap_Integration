import 'package:equatable/equatable.dart';

class PlacePredictionModel extends Equatable {
  final String place;
  final String placeId;
  final Textmodel text;
  final List<dynamic> types;

  PlacePredictionModel(
      {required this.place,
      required this.placeId,
      required this.text,
      required this.types});
  factory PlacePredictionModel.fromJson(Map<String, dynamic> data) {
    return PlacePredictionModel(
      place: data["place"],
      placeId: data["placeId"],
      text: Textmodel.fromJson(data["text"]),
      types: data["types"].cast<String>(),
    );
  }

  @override
  List<Object?> get props => [placeId];
}

class Textmodel {
  final String text;
  final List<dynamic> matches;

  Textmodel({required this.text, required this.matches});
  factory Textmodel.fromJson(Map<String, dynamic> data) {
    return Textmodel(text: data["text"], matches: data["matches"]);
  }
}
