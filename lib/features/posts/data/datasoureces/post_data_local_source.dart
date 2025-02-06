import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/entities/posts.dart';
import 'package:flutter_posts/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
abstract class PostDataLocalSource{
  Future<List<Posts>> getCachedPost();
  Future<Unit> cachePosts(List<PostModel> posts);

}
class PostDataLocalSourceImp implements PostDataLocalSource{
  final SharedPreferences sharedPreferences;
  PostDataLocalSourceImp({required this.sharedPreferences});
  @override
  Future<List<Posts>> getCachedPost() {

    final jsonString = sharedPreferences.getString('cached_posts');
    if(jsonString != null){
      List decodeJsonData = json.decode(jsonString);
      List<Posts> cachedPosts = decodeJsonData.map((post) => PostModel.fromJson(post)).toList();
      return Future.value(cachedPosts);
    }else{
      throw EmptyCacheException();
    }
   
  }

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {

    List cachedPostsToJson = posts.map<Map<String, dynamic>>((post) => post.toJson()).toList();
    sharedPreferences.setString('cached_posts', json.encode(cachedPostsToJson));
    return Future.value(unit);


  }
  
}