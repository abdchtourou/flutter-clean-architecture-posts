import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_posts/core/string/messages.dart';
import 'package:flutter_posts/features/posts/domain/entities/posts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/string/failures.dart';
import '../../../domain/usecases/add_post_use_case.dart';
import '../../../domain/usecases/delete_post_use_case.dart';
import '../../../domain/usecases/update_post_use_case.dart';

part 'add_delete_update_event.dart';

part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;

  AddDeleteUpdateBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdateState());

        final response = await addPost(event.post);
        emit(_eitherAddDeleteUpdateState(response, ADD_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final response = await deletePost(event.idPost);
        emit(_eitherAddDeleteUpdateState(response, DELETE_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final response = await updatePost(event.posts);
        emit(_eitherAddDeleteUpdateState(response, UPDATE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdateState _eitherAddDeleteUpdateState(
      Either<Failure, Unit> either, String? message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateState(_mapFailureToMessage(failure)),
      (_) => MessageAddDeleteUpdateState(message!),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;

      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'Unexpected Error';
    }
  }
}
