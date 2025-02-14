
import 'package:dio/dio.dart';
import 'package:flutter_posts/core/api/api_services.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_inf.dart';
import 'features/posts/data/datasoureces/post_data_local_source.dart';
import 'features/posts/data/datasoureces/remote_data_source.dart';
import 'features/posts/data/repos/post_repo_imp.dart';
import 'features/posts/domain/repos/posts_repo.dart';
import 'features/posts/domain/usecases/add_post_use_case.dart';
import 'features/posts/domain/usecases/delete_post_use_case.dart';
import 'features/posts/domain/usecases/get_all_post_use_case.dart';
import 'features/posts/domain/usecases/update_post_use_case.dart';
import 'features/posts/presentation/bloc/add_or_delete_update_bloc/add_delete_update_bloc.dart';
import 'features/posts/presentation/bloc/posts/post_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostBloc(getAllPost: sl()));
  sl.registerFactory(() => AddDeleteUpdateBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepo>(() => PostRepoImp(
      remoteDataSource: sl(), postDataLocalSource: sl(), networkInf: sl()));

// Datasources

  sl.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImpl( apiServices: sl(), networkInf: sl()));
  sl.registerLazySingleton<PostDataLocalSource>(
          () => PostDataLocalSourceImp(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInf>(() => NetworkInfImpl(sl()));
  sl.registerLazySingleton<ApiServices>(()=>ApiServices(dio: sl()));

//! External


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}