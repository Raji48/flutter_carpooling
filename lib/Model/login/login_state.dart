


import 'package:carpooling/Model/login/login_model.dart';

class LoginState {
  bool loading;
  dynamic error;
  Loginmodel success;


  LoginState({
    this.loading,
    this.error,
    this.success,

});
  factory LoginState.initial() => LoginState(
         loading: false,
        error: null,
        success: null,


  );
}
