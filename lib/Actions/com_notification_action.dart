

import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Services/Apicontroller.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Services/index.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> comnotification(data) => (Store<AppState> store) =>
    putDioApi(
        COM_NOTIFICATION,
        data,
        [
          COM_NOTIFICATION_REQUEST,
          COM_NOTIFICATION_SUCCESS,
          COM_NOTIFICATION_FAILURE,
        ],
        store
    );
