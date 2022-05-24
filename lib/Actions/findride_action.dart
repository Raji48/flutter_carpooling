

import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/findride/findride_model.dart';
import 'package:carpooling/Screens/com_ride/scheduleride.dart';
import 'package:carpooling/Services/ApiTypes.dart';
import 'package:carpooling/Services/Apicontroller.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> findridecommuter(data) => (Store<AppState> store) =>
    putDioApi(
        COM_FIND_RIDE,
        data,
        [
          FIND_RIDE_REQUEST,
          FIND_RIDE_SUCCESS,
          FIND_RIDE_FAILURE,
        ],
        store
    );
clearpropsride(data){
  return ResponseModal.responseResult(data.toString(),FIND_RIDE_CLEAR_PROPS);
}
ThunkAction<AppState> clearpropsfindride(data) => (Store<AppState> store) =>store.dispatch(clearpropsride(data));