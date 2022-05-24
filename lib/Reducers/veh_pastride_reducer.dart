

import 'package:carpooling/Model/veh_pastride/veh_pastride_model.dart';
import 'package:carpooling/Model/veh_pastride/veh_pastride_state.dart';
import 'package:carpooling/Services/constants.dart';

VehpastrideState vehpastrideReducer(VehpastrideState state, dynamic action) {
  VehpastrideState newState = state;

  switch (action.type) {

    case VEH_PAST_RIDE_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.vehpastride= null;
      return newState;

    case VEH_PAST_RIDE_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.vehpastride =Veh_owner_pastride_modal.fromJson(action.payload);
      return newState;

    case VEH_PAST_RIDE_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.vehpastride= null;
      return newState;

    case VEH_PAST_RIDE_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.vehpastride= null;
      }
      return newState;

    default:
      return newState;
  }
}
