
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/ApiTypes.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> commridereq(data) => (Store<AppState> store) =>
    postDioApi(
        COM_REQ_RIDE,
        data,
        [
          COM_REQ_RIDE_REQUEST,
          COM_REQ_RIDE_SUCCESS,
          COM_REQ_RIDE_FAILURE,
        ],
        store
    );

clearpropsreq(data){
  return ResponseModal.responseResult(data.toString(),COM_REQ_RIDE_CLEAR_PROPS);
}
ThunkAction<AppState> clearpropscomreqride(data) => (Store<AppState> store) =>store.dispatch(clearpropsreq(data));