
import 'package:carpooling/Model/veh_upcomingride/veh_upcomingride_model.dart';

class VehupcomingrideState {
  dynamic error;
  bool loading;
  Veh_owner_upcomingride_modal vehupcomride;


  VehupcomingrideState({
    this.error,
    this.loading,
    this.vehupcomride,
  });

  factory VehupcomingrideState.initial() =>
      VehupcomingrideState(
        loading: false,
        error: null,
        vehupcomride: null,
      );
}