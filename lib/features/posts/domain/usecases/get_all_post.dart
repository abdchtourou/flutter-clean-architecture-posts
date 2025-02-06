import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/repos/posts_repo.dart';

import '../../../../core/error/failure.dart';
import '../entities/posts.dart';

class GetAllPostUsecase {
  final PostsRepo postsRepo;

  GetAllPostUsecase(this.postsRepo);

  Future<Either<Failure, List<Posts>>> call() async {
    return await postsRepo.getAllPost();
  }
}
