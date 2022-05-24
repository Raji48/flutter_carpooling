
import 'package:carpooling/Model/findride/findride_model.dart';

class FindrideState {
  bool loading;
  dynamic error;
  FindrideModal rideresult;


  FindrideState({
    this.loading,
    this.error,
    this.rideresult,

  });
  factory FindrideState.initial() => FindrideState(
    loading: false,
    error: null,
    rideresult: null,

  );
}