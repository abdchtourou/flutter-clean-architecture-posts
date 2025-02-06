import 'package:dartz/dartz.dart';
import 'package:flutter_posts/core/error/exception.dart';
import 'package:flutter_posts/core/error/failure.dart';
import 'package:flutter_posts/core/network/network_inf.dart';
import 'package:flutter_posts/features/posts/data/datasoureces/post_data_local_source.dart';
import 'package:flutter_posts/features/posts/data/datasoureces/remote_data_source.dart';
import 'package:flutter_posts/features/posts/data/models/post_model.dart';
import 'package:flutter_posts/features/posts/domain/entities/posts.dart';

import '../../domain/repos/posts_repo.dart';

typedef Future<Unit> DeleteOrUpdateOrAdd();

class PostRepoImp implements PostsRepo {
  final RemoteDataSource remoteDataSource;
  final PostDataLocalSource postDataLocalSource;
  final NetworkInf networkInf;

  PostRepoImp(
      {required this.remoteDataSource,
      required this.postDataLocalSource,
      required this.networkInf});

  @override
  Future<Either<Failure, Unit>> addPost(Posts post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() async {
      return await remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() async {
      return remoteDataSource.deletePost(id);
    });
  }

  @override
  Future<Either<Failure, List<Posts>>> getAllPost() async {
    if (await networkInf.isConnected) {
      try {
        final response = await remoteDataSource.getAllPosts();
        postDataLocalSource.cachePosts(response);
        return Right(response);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postDataLocalSource.getCachedPost();
        return Right(localPosts);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Posts post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() async {
      return await remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAdd deleteOrUpdateOrAdd) async {
    if (await networkInf.isConnected) {
      try {
        await deleteOrUpdateOrAdd();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
  