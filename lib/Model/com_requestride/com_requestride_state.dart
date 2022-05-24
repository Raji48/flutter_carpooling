
import 'package:carpooling/Model/com_requestride/com_requestride_model.dart';

class CommuterreqrideState {
  dynamic error;
  bool loading;
  Commuter_req_modal comreqride;


  CommuterreqrideState({
    this.error,
    this.loading,
    this.comreqride,
  });

  factory CommuterreqrideState.initial() =>
      CommuterreqrideState(
        loading: false,
        error: null,
        comreqride: null,
      );
}