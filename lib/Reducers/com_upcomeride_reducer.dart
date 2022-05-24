

import 'package:carpooling/Model/com_upcomingride/com_upcomingride_modal.dart';
import 'package:carpooling/Model/com_upcomingride/com_upcomingride_state.dart';
import 'package:carpooling/Services/constants.dart';

ComupcomingrideState comupcomeReducer(ComupcomingrideState state, dynamic action) {
  ComupcomingrideState newState = state;

  switch (action.type) {

    case COM_UPCOME_RIDE_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.comupcomeride= null;
      return newState;

    case COM_UPCOME_RIDE_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.comupcomeride= Com_upcomingride_modal.fromJson(action.payload);
      return newState;

    case COM_UPCOME_RIDE_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.comupcomeride= null;
      return newState;

    case COM_UPCOME_RIDE_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.comupcomeride= null;
      }
      return newState;

    default:
      return newState;
  }
}
