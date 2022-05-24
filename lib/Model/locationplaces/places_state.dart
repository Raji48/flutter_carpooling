
import 'package:carpooling/Model/locationplaces/places_model.dart';

class PlacesState {
  dynamic error;
  bool loading;
  Placesmodal placelists;



  PlacesState({
    this.error,
    this.loading,
    this.placelists
  });

  factory PlacesState.initial() =>
      PlacesState(
        loading: false,
        error: null,
        placelists: null,
      );
}