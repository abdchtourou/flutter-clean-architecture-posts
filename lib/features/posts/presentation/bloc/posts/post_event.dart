part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();
}

class GetAllPost extends PostEvent {
  const GetAllPost();
  
  @override
  List<Object> get props => [];
}

class RefreshPost extends PostEvent {
  const RefreshPost();
  
  @override
  List<Object> get props => [];
}
