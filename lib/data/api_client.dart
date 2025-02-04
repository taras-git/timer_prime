import 'package:dio/dio.dart';

class DioClient {
  static const String _baseUrl =
      "http://www.randomnumberapi.com/";

  DioClient() {
    addInterceptor(LogInterceptor());
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: _baseUrl),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
