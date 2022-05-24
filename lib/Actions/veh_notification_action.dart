
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> vehnotification(data) => (Store<AppState> store) =>
    putDioApi(
        VEH_OWNER_NOTIFICATION,
        data,
        [
          VEH_NOTIFICATION_REQUEST,
          VEH_NOTIFICATION_SUCCESS,
          VEH_NOTIFICATION_FAILURE,
        ],
        store
    );

// clearprops(data){
//   return ResponseModal.responseResult(data.toString(),VEH_UPCOM_RIDE_CLEAR_PROPS);
// }
// ThunkAction<AppState> clearpropsupcomride(data) => (Store<AppState> store) =>store.dispatch(clearprops(data));