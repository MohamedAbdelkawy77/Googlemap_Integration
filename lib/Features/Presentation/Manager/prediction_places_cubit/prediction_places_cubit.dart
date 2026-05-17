import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/Features/Data/DataSource/data_implement/data_implement.dart';
import 'package:googlemap/Features/Presentation/Manager/prediction_places_cubit/prediction_places_state.dart';

class PredictionPlacesCubit extends Cubit<PredictionPlacesState> {
  PredictionPlacesCubit() : super(PredictionPlacesStateLoading());
  DataImplement dataImplement = DataImplement();

  void getpredictionplaces(String data) async {
    emit(PredictionPlacesStateLoading());
    final result = await dataImplement.predictionplaces(data);
    result.fold((fail) {
      emit(PredictionPlacesStateFailur(message: fail.message));
    }, (success) {
      emit(PredictionPlacesStateSuccess(places: success));
    });
  }

  void getplaceinfo(String id) async {
    final result = await dataImplement.placeinfo(id);
    emit(PlacesinfoStateLoading());
    result.fold((fail) {
      emit(PlacesinfosStateFailur(message: fail.message));
    }, (success) {
      emit(PlacesinfoStateSuccess(place: success));
    });
  }
}
