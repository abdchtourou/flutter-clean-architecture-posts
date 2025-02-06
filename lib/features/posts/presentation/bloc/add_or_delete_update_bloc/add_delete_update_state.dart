part of 'add_delete_update_bloc.dart';

sealed class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AddDeleteUpdateInitial extends AddDeleteUpdateState {
  @override
  List<Object> get props => [];
}

class LoadingAddDeleteUpdateState extends AddDeleteUpdateState {}

class MessageAddDeleteUpdateState extends AddDeleteUpdateState {
  final String message;

  const MessageAddDeleteUpdateState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ErrorAddDeleteUpdateState extends AddDeleteUpdateState {
  final String errorMessage;

  const ErrorAddDeleteUpdateState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
