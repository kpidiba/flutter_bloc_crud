import 'package:bloc/bloc.dart';
import 'package:bloccrud_muhammedessa/models/postmodel.dart';
import 'package:bloccrud_muhammedessa/repository/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  PostBloc(this.postRepository) : super(const PostLoadingState()) {
    on<LoadPostEvent>(((event, emit) async {
      emit(const PostLoadingState());
      try {
        final posts = await postRepository.getPosts();
        emit(PostLoadedState(posts));
      } catch (e) {
        emit(PostErrorState(e.toString()));
      }
    }));

    on<AddPostEvent>(((event, emit) async {
      emit(const PostLoadingState());
      try {
        bool a = await postRepository.createPost(
            PostModel(id: event.userId, title: event.title, body: event.body));
        if (!a) {
          emit(const PostErrorState("error register"));
        }
        emit(const PostSuccessState("post success register"));
      } catch (e) {
        emit(PostErrorState(e.toString()));
      }
    }));

    on<UpdatePostEvent>(((event, emit) async {
      emit(const PostLoadingState());
      try {
        bool a = await postRepository.updatePost(event.post);
        if (!a) {
          emit(const PostErrorState("error update"));
        }
        emit(const PostSuccessState("post success update"));
      } catch (e) {
        emit(PostErrorState(e.toString()));
      }
    }));

    on<FetchSpecificPostEvent>(((event, emit) async {
      emit(const PostLoadingState());
      try {
        final post = await postRepository.getPostById(event.id);
        List<PostModel> posts = [];
        posts.add(post);
        emit(PostLoadedState(posts));
      } catch (e) {
        emit(PostErrorState(e.toString()));
      }
    }));

    on<DeletePostEvent>(((event, emit) async {
      emit(const PostLoadingState());
      await postRepository.deletePost(event.id);
      add(LoadPostEvent());
    }));
  }
}
