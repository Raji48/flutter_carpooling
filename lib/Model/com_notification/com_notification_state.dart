
import 'package:carpooling/Model/com_notification/com_notification_modal.dart';

class ComnotificationState {
  dynamic error;
  bool loading;
  Com_notification_modal comnotification;


  ComnotificationState({
    this.error,
    this.loading,
    this.comnotification
  });


  factory ComnotificationState.initial() =>
      ComnotificationState(
        loading: false,
        error: null,
        comnotification: null,
      );
}