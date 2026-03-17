import 'package:dio/dio.dart';
import 'package:movie/core/exceptions/exception_model.dart';

class ExceptionsHandler {
  static void dioExceptionsHandler(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        throw ExceptionModel.fromJson(exception.response!.data);
      case DioExceptionType.sendTimeout:
        throw ExceptionModel.fromJson(exception.response!.data);
      case DioExceptionType.receiveTimeout:
        throw ExceptionModel.fromJson(exception.response!.data);
      case DioExceptionType.badCertificate:
        throw ExceptionModel.fromJson(exception.response!.data);
      case DioExceptionType.cancel:
        throw ExceptionModel.fromJson(exception.response!.data);
      case DioExceptionType.connectionError:
        throw ExceptionModel.fromJson(exception.response!.data);
      case DioExceptionType.unknown:
        throw ExceptionModel.fromJson(exception.response!.data);
      case DioExceptionType.badResponse:
        switch (exception.response?.statusCode) {
          case 400:
            throw ExceptionModel.fromJson(exception.response!.data);
          case 401:
            throw ExceptionModel.fromJson(exception.response!.data);
          case 403:
            throw ExceptionModel.fromJson(exception.response!.data);
          case 404:
            throw ExceptionModel.fromJson(exception.response!.data);
          case 409:
            throw ExceptionModel.fromJson(exception.response!.data);
          case 422:
            throw ExceptionModel.fromJson(exception.response!.data);
          case 504:
            throw ExceptionModel.fromJson(exception.response!.data);
        }
    }
  }
}
