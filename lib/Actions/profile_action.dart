
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/ApiTypes.dart';
import 'package:carpooling/Services/Apicontroller.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


ThunkAction<AppState> profiledata() => (Store<AppState> store) =>
    getDioApi(
        PROFILE_DETAILS,
        [
          GET_PROF_DETAILS_REQUEST,
          GET_PROF_DETAILS_SUCCESS,
          GET_PROF_DETAILS_FAILURE,
        ],
        store
    );

