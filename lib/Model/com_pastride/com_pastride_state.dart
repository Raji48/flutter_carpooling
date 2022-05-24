
import 'package:carpooling/Model/com_pastride/com_pastride_model.dart';

class CompastrideState {
  dynamic error;
  bool loading;
  Com_pastride_modal compastride;


  CompastrideState({
    this.error,
    this.loading,
    this.compastride
  });

  factory CompastrideState.initial() =>
      CompastrideState(
        loading: false,
        error: null,
        compastride: null,
      );
}