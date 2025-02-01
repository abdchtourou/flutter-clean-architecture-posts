import 'package:dartz/dartz.dart';
import 'package:flutter_posts/core/error/failure.dart';
import 'package:flutter_posts/features/posts/domain/entities/posts.dart';
import 'package:flutter_posts/features/posts/data/datasoureces/remote_data_source.dart';

import '../../domain/repos/posts_repo.dart';
class PostRepoImp implements PostsRepo {
  final RemoteDataSource remoteDataSource;

  PostRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, Unit>> addPost(Posts post) async{
    return await remoteDataSource.addPost(post);
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Posts>>> getAllPost() {
    // TODO: implement getAllPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Posts post       ) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
  



  
  


}