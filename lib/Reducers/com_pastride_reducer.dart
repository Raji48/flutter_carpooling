

import 'package:carpooling/Model/com_pastride/com_pastride_model.dart';
import 'package:carpooling/Model/com_pastride/com_pastride_state.dart';
import 'package:carpooling/Services/constants.dart';

CompastrideState compastrideReducer(CompastrideState state, dynamic action) {
  CompastrideState newState = state;

  switch (action.type) {

    case COM_PAST_RIDE_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.compastride= null;
      return newState;

    case COM_PAST_RIDE_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.compastride=Com_pastride_modal.fromJson(action.payload);
      return newState;

    case COM_PAST_RIDE_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.compastride= null;
      return newState;

    case COM_PAST_RIDE_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.compastride= null;
      }
      return newState;

    default:
      return newState;
  }
}
