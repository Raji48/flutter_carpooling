
import 'package:carpooling/Model/verifyphonenumber/verifynumber_model.dart';

class VerifynumberState {
  bool loading;
  dynamic error;
  Verifynumber success;


  VerifynumberState({
    this.loading,
    this.error,
    this.success,

  });
  factory VerifynumberState.initial() => VerifynumberState(
    loading: false,
    error: null,
    success: null,
  );
}