



import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/Apicontroller.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> requestedride(data) => (Store<AppState> store) =>
    putDioApi(
        COM_REQUESTED_RIDE,
        data,
        [
          REQ_RIDE_REQUEST,
          REQ_RIDE_SUCCESS,
          REQ_RIDE_FAILURE,
        ],
        store
    );