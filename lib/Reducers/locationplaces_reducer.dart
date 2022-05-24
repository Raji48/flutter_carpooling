
import 'package:carpooling/Model/locationplaces/places_model.dart';
import 'package:carpooling/Model/locationplaces/places_state.dart';
import 'package:carpooling/Services/constants.dart';

PlacesState placeReducer(PlacesState state, dynamic action) {
  PlacesState newState = state;

  switch (action.type) {

    case PLACES_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.placelists = null;
      return newState;

    case PLACES_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.placelists= Placesmodal.fromJson(action.payload);
      return newState;

    case PLACES_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.placelists = null;
      return newState;

    case FIND_RIDE_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.placelists= null;
      }
      return newState;


    default:
      return newState;
  }
}
