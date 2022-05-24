
import 'package:carpooling/Model/veh_notification/veh_notification_modal.dart';
import 'package:carpooling/Model/veh_notification/veh_notification_state.dart';
import 'package:carpooling/Services/constants.dart';

VehnotificationState vehnotificationReducer(VehnotificationState state, dynamic action) {
  VehnotificationState newState = state;

  switch (action.type) {

    case VEH_NOTIFICATION_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.vehnotification = null;
      return newState;

    case VEH_NOTIFICATION_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.vehnotification = Veh_owner_notification_modal.fromJson(action.payload);
      return newState;

    case VEH_NOTIFICATION_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.vehnotification= null;
      return newState;

    case VEH_NOTIFICATION_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.vehnotification= null;
      }
      return newState;

    default:
      return newState;
  }
}
