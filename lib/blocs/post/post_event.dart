part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadPostEvent extends PostEvent {
  @override
  List<Object> get props => [];
}

class AddPostEvent extends PostEvent {
  final String title;
  final String body;
  final int userId;
  const AddPostEvent({required this.title, required this.body, required this.userId});
  @override
  List<Object> get props => [userId, title, body];
}

class UpdatePostEvent extends PostEvent {
  final PostModel post;
  const UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class FetchSpecificPostEvent extends PostEvent {
  final int id;
  const FetchSpecificPostEvent({required this.id});
  @override
  List<Object> get props => [id];
}


class DeletePostEvent extends PostEvent {
  final int id;
  const DeletePostEvent({required this.id});
  @override
  List<Object> get props => [id];
}