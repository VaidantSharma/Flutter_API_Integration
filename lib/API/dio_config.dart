import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Api {
  final dio = createDio();
  String _token = "";

  String _apiKey = "";

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(baseUrl: 'https:www.example.com',
      // connectTimeout: 30000,
      // receiveTimeout: 30000,
      // sendTimeout: 30000,
    ));
    dio.interceptors.addAll({ErrorInterceptor(dio)});
    return dio;
  }

  String get token => _token;

  set token(String? value) {
    if (value != null && value.isNotEmpty) {
      _token = value;
    }
  }

  String get apiKey => _apiKey;

  set apikey(String ? value) {
    if (value != null && value.isNotEmpty) {
      _apiKey = value;
    }
  }

  clearKeyToken() {
    _token = "";
    _apiKey = "";
  }

  Future<Response> get(String path, {
    Map<String, dynamic> ? queryParameter,
    Options ? options,
    CancelToken ? cancelToken,
    void Function (int, int )? onReciveProgress,
    bool addRequestInterceptor = true,
  }) async {
    print("Getting Api from  : ${this.dio.options.baseUrl + path}");
    if (addRequestInterceptor) {
      dio.interceptors.add(
          RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    print("QUERY PARAMS => ${queryParameter}");
    return await dio.get(
      this.dio.options.baseUrl + path, onReceiveProgress: onReciveProgress,
      cancelToken: cancelToken,
      options: options,
      queryParameters: queryParameter,);
  }

  Future<Response> post(String path, { dynamic data, Map<String,
      dynamic> ?queryParameters, Options?options,
    CancelToken?cancelToken,
    void Function(int, int )? onSendProgress,
    void Function(int, int )? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    print("URL : ${this.dio.options.baseUrl + path}");
    print("Request Body : ${data}");
    if (addRequestInterceptor) {
      dio.interceptors.add(
          RequestInterceptor(dio, apiKey: apiKey, token: token,));
    }
    return await dio.post(
      this.dio.options.baseUrl + path, data: FormData.fromMap(data),
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,);
  }

}

class RequestInterceptor extends Interceptor {
  final Dio dio;

  final String apiKey;
  final String token;

  RequestInterceptor(this.dio, {required this.apiKey, required this.token});
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler ){
    options.headers = {'apiKey': apiKey, 'token': token};
    return handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  final Dio dio;

  ErrorInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeOutException(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        throw ReceiveTimeOutException(err.requestOptions);
      case DioExceptionType.sendTimeout:
        throw SendTimeOutException(err.requestOptions);
      case DioExceptionType.badResponse:
        print('Status code : ${err.response?.statusCode}');
        print('${err.response?.data}');
        switch (err.response?.statusCode) {
          case 400 :
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.unknown:
        print(err.message);
        throw Text('Internet Connection error');
    }
    return handler.next(err);
  }
}
class ConnectionTimeOutException extends DioException{
  ConnectionTimeOutException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'Connection Timed Out, please try again ';
  }
}
class ReceiveTimeOutException extends DioException{
  ReceiveTimeOutException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'Receive Timed out, Please try again';
  }
}
class SendTimeOutException extends DioException{
  SendTimeOutException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'Send Timed out, Please try again';
  }
}
class BadRequestException extends DioException{
  BadRequestException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'Invalid request';
  }
}
class UnauthorizedException extends DioException{
  UnauthorizedException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'Access denied';
  }
}
class NotFoundException extends DioException{
  NotFoundException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'The page you are looking for was not found';
  }
}
class ConflictException extends DioException{
  ConflictException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'Conflict occurred';
  }
}
class InternalServerErrorException extends DioException{
  InternalServerErrorException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'Internal Server Error';
  }
}
class NoInternetConnectionException extends DioException{
  NoInternetConnectionException(RequestOptions r): super(requestOptions: r);
  @override
  String toString() {
    return 'No Internet !';
  }
}



