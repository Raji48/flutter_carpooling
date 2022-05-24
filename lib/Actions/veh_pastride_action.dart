
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> vehpastride(data) => (Store<AppState> store) =>
    putDioApi(
        VEH_OWNER_PAST_RIDE,
        data,
        [
          VEH_PAST_RIDE_REQUEST,
          VEH_PAST_RIDE_SUCCESS,
          VEH_PAST_RIDE_FAILURE,
        ],
        store
    );