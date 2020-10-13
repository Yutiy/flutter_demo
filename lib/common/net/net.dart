import 'package:dio/dio.dart';
import "package:flutter_demo/common/net/interceptors/header_interceptor.dart";
import "error_handler.dart";

/// http请求
class HttpManager {
  Dio _dio = new Dio(); // 使用默认配置

  HttpManager() {
    _dio.interceptors.add(new HeaderInterceptor());

    /// Fiddler抓包代理配置 https://www.jianshu.com/p/d831b1f7c45b
    // if (!AppConfig.inProduction) {
    //   (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (HttpClient client) {
    //     client.findProxy = (uri) {
    //       //proxy all request to localhost:8888
    //       return 'PROXY 10.41.0.132:8888';
    //     };
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  netFetch(
    String method,
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    Response response;
    try {
      response = await _dio.request<String>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken,
      );
    } catch (e) {
      return ExceptionHandle.handleException(e);
    }

    return response.data;
  }

  Options _checkOptions(String method, Options options) {
    options ??= Options();
    options.method = method;
    return options;
  }
}
