/*import 'package:redux/redux.dart';

import 'package:redux_api_middleware/redux_api_middleware.dart';

void loggingMiddleware<State>(
    Store<State> store,
    dynamic action,
    NextDispatcher next,
    ) {
 // if (action is FSA) {
    print('{');
    print('  Action: ${action.type.toString()}');
    // print('  Action: ${action.type}');

    if (action.payload != null) {
      print('  StatusCode: ${action.statuscode.toString()}');
      // print('  Error: ${action.error}');
      print('  Payload: ${action.payload.toString()}');
      //print('  Payload: ${action.payload}');
    }

    print('}');
  //}

  next(action);
}*/