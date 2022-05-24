


import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> comupcomeride(data) => (Store<AppState> store) =>
    putDioApi(
        COM_UPCOMING_RIDE,
        data,
        [
          COM_UPCOME_RIDE_REQUEST,
          COM_UPCOME_RIDE_SUCCESS,
          COM_UPCOME_RIDE_FAILURE,
        ],
        store
    );

// clearpropsreq(data){
//   return ResponseModal.responseResult(data.toString(),COM_REQ_RIDE_CLEAR_PROPS);
// }
// ThunkAction<AppState> clearpropscomreqride(data) => (Store<AppState> store) =>store.dispatch(clearpropsreq(data));