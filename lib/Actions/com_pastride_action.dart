

import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> compastride(data) => (Store<AppState> store) =>
    putDioApi(
        COM_PAST_RIDE,
        data,
        [
          COM_PAST_RIDE_REQUEST,
          COM_PAST_RIDE_SUCCESS,
          COM_PAST_RIDE_FAILURE,
        ],
        store
    );
