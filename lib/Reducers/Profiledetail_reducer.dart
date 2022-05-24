
import 'dart:convert';
import 'package:carpooling/Model/profiledetail/profiledetail_model.dart';
import 'package:carpooling/Model/profiledetail/profiledetail_state.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:http/http.dart'as http;

ProfileState profileReducer(ProfileState state, dynamic action) {
  ProfileState newState = state;
  switch (action.type) {
    case GET_PROF_DETAILS_REQUEST:
      newState.error = null;
      newState.loading = true;
      newState.userdata = null;
      return newState;


    case GET_PROF_DETAILS_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.userdata = Profiledetails.fromJson(action.payload);
      return newState;

    case GET_PROF_DETAILS_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.userdata = null;
      return newState;

    default:
      return newState;

}

}

