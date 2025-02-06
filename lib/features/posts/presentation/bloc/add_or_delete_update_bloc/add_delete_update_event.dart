part of 'add_delete_update_bloc.dart';

sealed class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();
}

class AddPostEvent extends AddDeleteUpdateEvent {
  final Posts post;

  const AddPostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdateEvent {
  final Posts posts;

  const UpdatePostEvent({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class DeletePostEvent extends AddDeleteUpdateEvent {
  final int idPost;

  const DeletePostEvent({required this.idPost});

  @override
  List<Object?> get props => [idPost];
}
