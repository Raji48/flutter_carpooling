
import 'package:carpooling/Model/com_requestride/com_requestride_model.dart';
import 'package:carpooling/Model/com_requestride/com_requestride_state.dart';
import 'package:carpooling/Services/constants.dart';

CommuterreqrideState comreqrideReducer(CommuterreqrideState state, dynamic action) {
  CommuterreqrideState newState = state;

  switch (action.type) {

    case COM_REQ_RIDE_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.comreqride = null;
      return newState;

    case COM_REQ_RIDE_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.comreqride = Commuter_req_modal.fromJson(action.payload);
      return newState;

    case COM_REQ_RIDE_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.comreqride= null;
      return newState;

    case COM_REQ_RIDE_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.comreqride= null;
      }
      return newState;

    default:
      return newState;
  }
}
