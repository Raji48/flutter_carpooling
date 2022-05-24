

import 'package:carpooling/Model/login/login_model.dart';
import 'package:carpooling/Model/login/login_state.dart';
import 'package:carpooling/Services/constants.dart';

LoginState loginReducer(LoginState state, dynamic action) {
  LoginState newState = state;

  switch (action.type) {

    case LOGIN_REQUEST:
      newState.error = null;
      newState.loading = true;
      newState.success = null;
      return newState;

    case LOGIN_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.success = Loginmodel.fromJson(action.payload);
      return newState;

    case LOGIN_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.success = null;
      return newState;
  }
}