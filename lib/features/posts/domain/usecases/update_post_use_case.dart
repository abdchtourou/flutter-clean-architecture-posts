import 'package:dartz/dartz.dart';
import 'package:flutter_posts/core/error/failure.dart';
import 'package:flutter_posts/features/posts/domain/repos/posts_repo.dart';

import '../entities/posts.dart';

class UpdatePostUseCase {
  final PostsRepo postsRepo;

  UpdatePostUseCase(this.postsRepo);

  Future<Either<Failure, Unit>> call(Posts post) async {
    return await postsRepo.updatePost(post);
    }
}
