
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/ApiTypes.dart';
import 'package:carpooling/Services/Apicontroller.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> login(data) => (Store<AppState> store) =>
    postDioApi(
        LOGIN,
        data,
        [
          LOGIN_REQUEST,
          LOGIN_SUCCESS,
          LOGIN_FAILURE,
        ],
        store
    );