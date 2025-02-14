import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_posts/core/error/failure.dart';
import 'package:flutter_posts/features/posts/domain/entities/posts.dart';
import 'package:flutter_posts/features/posts/domain/usecases/get_all_post_use_case.dart';

import '../../../../../core/string/failures.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostUseCase getAllPost;

  PostBloc({required this.getAllPost}) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetAllPost) {
        emit(PostLoading());
        final failureOrPosts = await getAllPost();
        emit(_mapFailureOrPosts(failureOrPosts));
      } else if (event is RefreshPost) {
        emit(_mapFailureOrPosts(await getAllPost()));
      }
    });
  }

  PostState _mapFailureOrPosts(Either<Failure, List<Posts>> failureOrPosts) {
    return failureOrPosts.fold(
        (failure) => PostError(_mapFailureToMessage(failure)),
        (posts) => PostLoaded(posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (EmptyCacheFailure):
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
