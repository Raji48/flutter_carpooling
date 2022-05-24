
import 'package:carpooling/Model/veh_pastride/veh_pastride_model.dart';

class VehpastrideState {
  dynamic error;
  bool loading;
  Veh_owner_pastride_modal vehpastride;


  VehpastrideState({
    this.error,
    this.loading,
    this.vehpastride,
  });

  factory VehpastrideState.initial() =>
      VehpastrideState(
        loading: false,
        error: null,
        vehpastride: null,
      );
}