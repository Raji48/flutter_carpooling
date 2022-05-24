
import 'package:carpooling/Model/veh_notification/veh_notification_modal.dart';

class VehnotificationState {
  dynamic error;
  bool loading;
  Veh_owner_notification_modal vehnotification;


  VehnotificationState({
    this.error,
    this.loading,
    this.vehnotification
  });


  factory VehnotificationState.initial() =>
      VehnotificationState(
        loading: false,
        error: null,
        vehnotification: null,
      );
}