

import 'package:carpooling/Model/com_notification/com_notification_modal.dart';
import 'package:carpooling/Model/com_notification/com_notification_state.dart';
import 'package:carpooling/Services/constants.dart';

ComnotificationState comnotificationReducer(ComnotificationState state, dynamic action) {
  ComnotificationState newState = state;

  switch (action.type) {

    case COM_NOTIFICATION_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.comnotification = null;
      return newState;

    case COM_NOTIFICATION_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.comnotification = Com_notification_modal.fromJson(action.payload);
      return newState;

    case COM_NOTIFICATION_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.comnotification= null;
      return newState;

    case COM_NOTIFICATION_CLEAR_PROPS:
      if(action.payload=="true"){
        newState.error = null;
        newState.loading = false;
        newState.comnotification= null;
      }
      return newState;

    default:
      return newState;
  }
}
