import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio;

  ApiServices({required this.dio});

  Future<Response> getData(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> deleteData(String endpoint) async {
    try {
      final response = await dio.delete(endpoint);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> updateData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.put(endpoint, data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
