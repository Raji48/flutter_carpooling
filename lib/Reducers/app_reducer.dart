

import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Reducers/Profiledetail_reducer.dart';
import 'package:carpooling/Reducers/com_notification_reducer.dart';
import 'package:carpooling/Reducers/com_pastride_reducer.dart';
import 'package:carpooling/Reducers/com_reqride_reducer.dart';
import 'package:carpooling/Reducers/com_upcomeride_reducer.dart';
import 'package:carpooling/Reducers/findride_reducer.dart';
import 'package:carpooling/Reducers/locationplaces_reducer.dart';
import 'package:carpooling/Reducers/requested_ride_reducer.dart';
import 'package:carpooling/Reducers/veh_notification_reducer.dart';
import 'package:carpooling/Reducers/veh_pastride_reducer.dart';
import 'package:carpooling/Reducers/veh_upcomride_reducer.dart';
import 'package:carpooling/Reducers/vehicle_reducer.dart';

import 'login_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    login: loginReducer(state.login, action),
      profdetails: profileReducer(state.profdetails, action),
    postsState: vehReducer(state.postsState, action),
      rideresults:findrideReducer(state.rideresults,action),
      vehupcomride:vehupcomrideReducer(state.vehupcomride,action),
      placelist:placeReducer(state.placelist,action),
    comreqride: comreqrideReducer(state.comreqride,action),
    vehnotification: vehnotificationReducer(state.vehnotification, action),
    comnotification: comnotificationReducer(state.comnotification, action),
    reqstdride: requestedrideReducer(state.reqstdride, action),
    vehpastride: vehpastrideReducer(state.vehpastride, action),
    comupcomeride: comupcomeReducer(state.comupcomeride, action),
    compastride: compastrideReducer(state.compastride, action),
  );
}