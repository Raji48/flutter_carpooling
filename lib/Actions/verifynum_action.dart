
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> verifynum(data) => (Store<AppState> store) =>
    postDioApi(
        VERIFY_PHONE_NUMBER,
        data,
        [
          VERIFY_REQUEST,
          VERIFY_SUCCESS,
          VERIFY_FAILURE,
        ],
        store
    );