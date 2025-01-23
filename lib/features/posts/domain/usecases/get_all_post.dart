import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/repos/posts_repo.dart';

import '../../../../core/error/failure.dart';
import '../entities/posts.dart';

class GetAllPost {
  final PostsRepo postsRepo;

  GetAllPost(this.postsRepo);

  Future<Either<Failure, List<Posts>>> call() async {
    return await postsRepo.getAllPost();
  }
}
