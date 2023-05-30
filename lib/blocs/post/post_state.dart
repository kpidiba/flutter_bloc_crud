part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {
  const PostLoadingState();

  @override
  List<Object> get props => [];
}

class PostLoadedState extends PostState {
  final List<PostModel> posts;
  const PostLoadedState(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostErrorState extends PostState {
  final String error;
  const PostErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class PostSuccessState extends PostState {
  final String message;
  const PostSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

class PostSpecificState extends PostState {
  final PostModel postModel;
  const PostSpecificState(this.postModel);

  @override
  List<Object> get props => [postModel];
}
