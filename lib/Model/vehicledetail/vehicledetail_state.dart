//@immutable
import 'package:carpooling/Model/vehicledetail/vehicledetail_model.dart';


class PostsState {
   bool error;
   bool loading;
   Vehicledetail posts;

  PostsState({
    this.error,
    this.loading,
    this.posts,
  });

  factory PostsState.initial() => PostsState(
    loading: false,
    error: false,
    posts: null,
  );

  /*PostsState copyWith({
    @required bool error,
    @required bool loading,
    @required Vehicledetail posts,
  }) {
    return PostsState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      posts: posts ?? this.posts,
    );
  }*/
}