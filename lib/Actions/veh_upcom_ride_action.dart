
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> vehupcomride(data) => (Store<AppState> store) =>
    putDioApi(
        VEH_OWNER_UPCOMING_RIDE,
        data,
        [
          VEH_UPCOM_RIDE_REQUEST,
          VEH_UPCOM_RIDE_SUCCESS,
          VEH_UPCOM_RIDE_FAILURE,
        ],
        store
    );

clearprops(data){
  return ResponseModal.responseResult(data.toString(),VEH_UPCOM_RIDE_CLEAR_PROPS);
}
ThunkAction<AppState> clearpropsupcomride(data) => (Store<AppState> store) =>store.dispatch(clearprops(data));