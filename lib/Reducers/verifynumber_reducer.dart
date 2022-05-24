
import 'package:carpooling/Model/verifyphonenumber/verifynumber_model.dart';
import 'package:carpooling/Model/verifyphonenumber/verifynumber_state.dart';
import 'package:carpooling/Services/constants.dart';

VerifynumberState VerifynumberReducer(VerifynumberState state, dynamic action) {
  VerifynumberState newState = state;

  switch (action.type) {

    case VERIFY_REQUEST:
      newState.error = null;
      newState.loading = true;
      newState.success = null;
      return newState;

    case VERIFY_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.success = Verifynumber.fromJson(action.payload);
      return newState;

    case VERIFY_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.success = null;
      return newState;
  }
}