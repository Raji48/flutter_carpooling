
import 'package:carpooling/Model/com_upcomingride/com_upcomingride_modal.dart';

class ComupcomingrideState {
  dynamic error;
  bool loading;
  Com_upcomingride_modal comupcomeride;



  ComupcomingrideState({
    this.error,
    this.loading,
    this.comupcomeride
  });

  factory ComupcomingrideState.initial() =>
      ComupcomingrideState(
        loading: false,
        error: null,
        comupcomeride: null,
      );
}