

import 'package:carpooling/Model/requested_ride/requested_ride_modal.dart';
import 'package:carpooling/Model/requested_ride/requested_ride_state.dart';
import 'package:carpooling/Services/constants.dart';

RequestedrideState requestedrideReducer(RequestedrideState state, dynamic action) {
  RequestedrideState newState = state;

  switch (action.type) {

    case REQ_RIDE_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.reqstdride= null;
      return newState;

    case REQ_RIDE_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.reqstdride = Requested_ride_modal.fromJson(action.payload);
      return newState;

    case REQ_RIDE_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.reqstdride= null;
      return newState;

    case REQ_RIDE_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.reqstdride= null;
      }
      return newState;

    default:
      return newState;
  }
}
