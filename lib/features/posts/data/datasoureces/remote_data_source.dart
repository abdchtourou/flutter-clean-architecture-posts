import 'package:dartz/dartz.dart';
import 'package:flutter_posts/core/api/api_services.dart';
import 'package:flutter_posts/core/network/network_inf.dart';
import 'package:flutter_posts/features/posts/data/models/post_model.dart';

import '../../../../core/error/exception.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiServices apiServices;
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  final NetworkInf networkInf;

  RemoteDataSourceImpl({required this.apiServices, required this.networkInf});

  @override
  Future<List<PostModel>> getAllPosts() async {
    if (await networkInf.isConnected) {
      final response = await apiServices.getData('$baseUrl/posts');
      final responseBody = response.data;
      return responseBody.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response =await apiServices.deleteData('$baseUrl/posts/$id');
    if (response.statusCode == 201) {
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
   final response= await apiServices.updateData(
      '$baseUrl/posts/${postModel.id}',
      postModel.toJson(),
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final response = await apiServices.postData(
      '$baseUrl/posts',
      postModel.toJson(),
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
}
