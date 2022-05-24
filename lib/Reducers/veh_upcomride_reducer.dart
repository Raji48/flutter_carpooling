

import 'package:carpooling/Model/veh_upcomingride/veh_upcomingride_model.dart';
import 'package:carpooling/Model/veh_upcomingride/veh_upcomingride_state.dart';
import 'package:carpooling/Services/constants.dart';

VehupcomingrideState vehupcomrideReducer(VehupcomingrideState state, dynamic action) {
  VehupcomingrideState newState = state;

  switch (action.type) {

    case VEH_UPCOM_RIDE_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.vehupcomride = null;
      return newState;

    case VEH_UPCOM_RIDE_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.vehupcomride = Veh_owner_upcomingride_modal.fromJson(action.payload);
      return newState;

    case VEH_UPCOM_RIDE_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.vehupcomride = null;
      return newState;

    case VEH_UPCOM_RIDE_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.vehupcomride= null;
      }
      return newState;

    default:
      return newState;
  }
}
