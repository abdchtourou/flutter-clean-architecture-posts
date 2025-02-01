import 'package:flutter_posts/core/api/api_services.dart';
import 'package:flutter_posts/features/posts/data/models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<void> deletePost(int id);
  Future<void> updatePost(PostModel postModel);
  Future<void> addPost(PostModel postModel);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiServices apiServices;
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  RemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await apiServices.getData('$baseUrl/posts');
    return (response.data as List)
        .map((post) => PostModel.fromJson(post))
        .toList();
  }

  @override
  Future<void> deletePost(int id) async {
    await apiServices.deleteData('$baseUrl/posts/$id');
  }

  @override
  Future<void> updatePost(PostModel postModel) async {
    await apiServices.updateData(
      '$baseUrl/posts/${postModel.id}',
      postModel.toJson(),
    );
  }

  @override
  Future<void> addPost(PostModel postModel) async {
    await apiServices.postData(
      '$baseUrl/posts',
      postModel.toJson(),
    );
  }
}