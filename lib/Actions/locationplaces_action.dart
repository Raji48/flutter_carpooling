



import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


ThunkAction<AppState> placeslist() => (Store<AppState> store) =>
    getDioApi(
        PLACES_LIST,
        [
          PLACES_REQUEST,
          PLACES_SUCCESS,
          PLACES_FAILURE,
        ],
        store
    );
clearprops(data){
  return ResponseModal.responseResult(data.toString(),PLACES_CLEAR_PROPS);
}
ThunkAction<AppState> clearpropsplaces(data) => (Store<AppState> store) =>store.dispatch(clearprops(data));