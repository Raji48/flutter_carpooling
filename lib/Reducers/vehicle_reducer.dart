


//action



import 'package:carpooling/Model/vehicledetail/vehicledetail_model.dart';
import 'package:carpooling/Model/vehicledetail/vehicledetail_state.dart';

import 'package:carpooling/Services/constants.dart';




PostsState vehReducer(PostsState state, dynamic action) {
  PostsState newState = state;

  switch (action.type) {

    case VEH_REQUEST:

      newState.error = null;
      newState.loading = true;
      newState.posts = null;
      return newState;

    case VEH_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.posts = Vehicledetail.fromJson(action.payload);
      return newState;

    case VEH_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.posts = null;
      return newState;

    default:
      return newState;
  }
}
