






import 'package:carpooling/Model/requested_ride/requested_ride_modal.dart';

class RequestedrideState {
  dynamic error;
  bool loading;
  Requested_ride_modal reqstdride;


  RequestedrideState({
    this.error,
    this.loading,
    this.reqstdride
  });


  factory RequestedrideState.initial() =>
      RequestedrideState(
        loading: false,
        error: null,
        reqstdride: null,
      );
}