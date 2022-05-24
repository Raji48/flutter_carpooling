


import 'package:carpooling/Model/findride/findride_model.dart';
import 'package:carpooling/Model/findride/findride_state.dart';
import 'package:carpooling/Services/constants.dart';

FindrideState findrideReducer(FindrideState state, dynamic action) {
  FindrideState newState = state;

  switch (action.type) {

    case FIND_RIDE_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.rideresult = null;
      return newState;

    case FIND_RIDE_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.rideresult= FindrideModal.fromJson(action.payload);
      return newState;

    case FIND_RIDE_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.rideresult= null;
      return newState;

    case FIND_RIDE_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.rideresult= null;
      }
      return newState;



    default:
      return newState;
  }
}



