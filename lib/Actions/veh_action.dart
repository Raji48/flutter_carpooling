
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/ApiTypes.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> vehicledata() => (Store<AppState> store) =>
    getDioApi(
        VEHICLE_DETAIL,
        [
          VEH_REQUEST,
          VEH_SUCCESS,
          VEH_FAILURE,
        ],
        store
    );
