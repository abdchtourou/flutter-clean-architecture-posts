import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/repos/posts_repo.dart';

import '../../../../core/error/failure.dart';

class DeletePost{
  final PostsRepo postsRepo;

  DeletePost(this.postsRepo);
  Future<Either<Failure,Unit>> call(int id) async{
    return await postsRepo.deletePost(id);

  }
}