

import 'package:carpooling/Model/profiledetail/profiledetail_model.dart';
import 'package:flutter/cupertino.dart';



class ProfileState {
  dynamic error;
  bool loading;
  Profiledetails userdata;

  ProfileState({
    this.error,
    this.loading,
    this.userdata,
  });

  factory ProfileState.initial() => ProfileState(
    error: null,
    loading: false,
    userdata: null,
  );

 /* ProfileState copyWith({
    @required bool error,
    @required bool loading,
    @required Profiledetails userdata,
  }) {
    return ProfileState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      userdata: userdata ?? this.userdata,

    );
  }*/
}
