import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie/core/exceptions/exceptions_handler.dart';
import 'package:movie/core/network/api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio _dio;

  DioConsumer(this._dio){
    _dio.options.baseUrl = "https://api.themoviedb.org/3";
    _dio.options.headers = {
      "Authorization": dotenv.env['API_TOKEN'],
      "accept": "application/json",};
    // _dio.interceptors.add(LogInterceptor(request: true, requestHeader: true, responseHeader: true, requestBody: true, responseBody: true));
  }

  @override
  Future get(String path, {dynamic data, Map<String, dynamic>? queryParams}) async {
    try{
      Response response = await _dio.get(path, data: data, queryParameters: queryParams);
      return response.data;
    }on DioException catch(exception){
      ExceptionsHandler.dioExceptionsHandler(exception);
    }
  }

  @override
  Future put(String path, {dynamic data, Map<String, dynamic>? queryParams, bool isFormData = false}) async {
    try{
      Response response = await _dio.put(path, data: isFormData ? FormData.fromMap(data) : data, queryParameters: queryParams);
      return response.data;
    }on DioException catch(exception){
      ExceptionsHandler.dioExceptionsHandler(exception);
    }
  }

  @override
  Future post(String path, {dynamic data, Map<String, dynamic>? queryParams, bool isFormData = false}) async {
    try{
      Response response = await _dio.post(path, data: isFormData ? FormData.fromMap(data) : data, queryParameters: queryParams);
      return response.data;
    }on DioException catch(exception){
      ExceptionsHandler.dioExceptionsHandler(exception);
    }
  }

  @override
  Future patch(String path, {dynamic data, Map<String, dynamic>? queryParams, bool isFormData = false}) async {
    try{
      Response response = await _dio.patch(path, data: isFormData ? FormData.fromMap(data) : data, queryParameters: queryParams);
      return response.data;
    }on DioException catch(exception){
      ExceptionsHandler.dioExceptionsHandler(exception);
    }
  }

  @override
  Future delete(String path, {dynamic data, Map<String, dynamic>? queryParams, bool isFormData = false}) async {
    try{
      Response response = await _dio.delete(path, data: isFormData ? FormData.fromMap(data) : data, queryParameters: queryParams);
      return response.data;
    }on DioException catch(exception){
      ExceptionsHandler.dioExceptionsHandler(exception);
    }
  }
}
