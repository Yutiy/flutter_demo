import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_demo/common/net/interceptors/connect_interceptor.dart';
import 'package:webview_flutter/webview_flutter.dart';
import "error_handler.dart";

// https://github.com/Cheney2006/flutter_utils/blob/master/lib/http/http_manager.dart

/// http请求
class HttpManager {
  // 单例
  factory HttpManager() => _getInstance();
  static HttpManager _instance;
  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._init();
    }
    return _instance;
  }

  static Dio _dio;

  static _init() async {
    final BaseOptions _options = BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 15000,
      sendTimeout: 10000,
      baseUrl: 'https://api.github.com/',
    );

    _dio = Dio(_options);

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

    // 网络连接拦截
    _dio.interceptors.add(ConnectInterceptor(_dio));

    // cookie拦截
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + "/dioCookie";
    CookieJar cj = PersistCookieJar(dir: tempPath, ignoreExpires: true);
    _dio.interceptors.add(CookieManager(cj));

    // 日志拦截
    _dio.interceptors.add(LogInterceptor());
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
      response = await _dio.request(
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

enum Method { get, post, put, patch, delete, head }

/// 使用拓展枚举替代 switch判断取值
/// https://zhuanlan.zhihu.com/p/98545689
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
