import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/entities/posts.dart';
abstract class PostDataLocalSource{
  Future<List<Posts>> getAllPost();
  Future<Unit> cachePosts(List<Posts> posts);

}
class PostDataLocalSourceImp implements PostDataLocalSource{
  @override
  Future<List<Posts>> getAllPost() {
    // TODO: implement getAllPost
    throw UnimplementedError();
  }

  @override
  cachePosts(List<Posts> posts) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }
  
}