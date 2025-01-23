import 'package:dartz/dartz.dart';
import 'package:flutter_posts/core/error/failure.dart';

import '../entities/posts.dart';

abstract class PostsRepo {
  Future<Either<Failure,List<Posts>>> getAllPost();

  Future<Either<Failure,Unit>> deletePost(int id);

  Future<Either<Failure,Unit>> updatePost(Posts post);

  Future<Either<Failure,Unit>> addPost(Posts post);
}
