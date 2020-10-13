import "package:dio/dio.dart";

class HeaderInterceptor extends Interceptor {
  static final String baseUrl = 'https://api.github.com/';

  @override
  Future onRequest(RequestOptions options) {
    options.baseUrl = baseUrl;

    /// 超时
    options.connectTimeout = 15000;
    options.receiveTimeout = 15000;
    options.sendTimeout = 10000;

    return super.onRequest(options);
  }
}
