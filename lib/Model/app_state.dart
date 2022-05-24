


import 'package:carpooling/Model/com_notification/com_notification_state.dart';
import 'package:carpooling/Model/com_pastride/com_pastride_state.dart';
import 'package:carpooling/Model/com_requestride/com_requestride_state.dart';
import 'package:carpooling/Model/com_upcomingride/com_upcomingride_state.dart';
import 'package:carpooling/Model/findride/findride_state.dart';
import 'package:carpooling/Model/locationplaces/places_state.dart';
import 'package:carpooling/Model/login/login_state.dart';

import 'package:carpooling/Model/profiledetail/profiledetail_state.dart';
import 'package:carpooling/Model/requested_ride/requested_ride_state.dart';
import 'package:carpooling/Model/veh_notification/veh_notification_state.dart';
import 'package:carpooling/Model/veh_pastride/veh_pastride_state.dart';
import 'package:carpooling/Model/veh_upcomingride/veh_upcomingride_state.dart';
import 'package:carpooling/Model/vehicledetail/vehicledetail_state.dart';
import 'package:carpooling/Model/verifyphonenumber/verifynumber_state.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppState {
  final LoginState login;
  final ProfileState profdetails;
  final PostsState postsState;
  final VerifynumberState verifynum;
  final FindrideState rideresults;
  final VehupcomingrideState vehupcomride;
  final PlacesState placelist;
  final CommuterreqrideState comreqride;
  final VehnotificationState vehnotification;
  final ComnotificationState comnotification;
  final RequestedrideState reqstdride;
  final VehpastrideState vehpastride;
  final ComupcomingrideState comupcomeride;
  final CompastrideState compastride;


  AppState({
    this.login,
    this.profdetails,
    this.postsState,
    this.verifynum,
    this.rideresults,
    this.vehupcomride,
    this.placelist,
    this.comreqride,
    this.vehnotification,
    this.comnotification,
    this.reqstdride,
    this.vehpastride,
    this.comupcomeride,
    this.compastride,
  });

  factory AppState.initial() => AppState(
    login: LoginState.initial(),
    profdetails: ProfileState.initial(),
   postsState: PostsState.initial(),
   verifynum: VerifynumberState.initial(),
   rideresults: FindrideState.initial(),
    vehupcomride: VehupcomingrideState.initial(),
    placelist: PlacesState.initial(),
    comreqride: CommuterreqrideState.initial(),
    vehnotification: VehnotificationState.initial(),
    comnotification: ComnotificationState.initial(),
    reqstdride: RequestedrideState.initial(),
    vehpastride:  VehpastrideState.initial(),
    comupcomeride: ComupcomingrideState.initial(),
    compastride: CompastrideState.initial(),

  );

  AppState copyWith({
    LoginState login,
    ProfileState profdet,
    PostsState postsState,
    VerifynumberState verifynum,
    FindrideState rideresults,
    VehupcomingrideState vehupcomride,
    PlacesState placelist,
    CommuterreqrideState comreqride,
    VehnotificationState vehnotification,
    ComnotificationState comnotification,
    RequestedrideState reqstdride,
    VehpastrideState vehpastride,
    ComupcomingrideState comupcomeride,
    CompastrideState compastride,

  }) {
    return AppState(
      login:login ?? this.login,
      profdetails: profdet ?? this.profdetails,
      postsState: postsState ?? this.postsState,
      verifynum: verifynum ?? this.verifynum,
      rideresults: rideresults ?? this.rideresults,
      vehupcomride: vehupcomride ?? this.vehupcomride,
      placelist: placelist ?? this.placelist,
      comreqride: comreqride ?? this.comreqride,
      vehnotification: vehnotification??this.vehnotification,
      comnotification: comnotification??this.comnotification,
      reqstdride: reqstdride??this.reqstdride,
      vehpastride: vehpastride?? this.vehpastride,
      comupcomeride: comupcomeride?? this.comupcomeride,
      compastride: compastride??this.compastride,
    );
  }
}