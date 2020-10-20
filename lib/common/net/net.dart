import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_demo/common/net/interceptors/connect_interceptor.dart';
import 'package:flutter_demo/common/net/interceptors/token_interceptor.dart';
import 'package:flutter_demo/common/net/result_data.dart';
import 'package:flutter_demo/utils/log_utils.dart';
import 'package:path_provider/path_provider.dart';
import "error_handler.dart";

/// 默认dio配置
int _connectTimeout = 15000;
int _receiveTimeout = 15000;
int _sendTimeout = 10000;
String _baseUrl;
List<Interceptor> _interceptors = [];

/// 初始化Dio配置
void setInitDio({
  int connectTimeout,
  int receiveTimeout,
  int sendTimeout,
  String baseUrl,
  List<Interceptor> interceptors,
}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

typedef HttpSuccessCallback<T> = Function(T data);
typedef HttpErrorCallback = Function(int code, String msg);

/// http请求
class HttpManager {
  // 单例
  factory HttpManager() => _getInstance();
  static HttpManager get instance => HttpManager();
  static HttpManager _singleton;
  static HttpManager _getInstance() {
    if (_singleton == null) {
      _singleton = HttpManager._init();
    }
    return _singleton;
  }

  static Dio _dio;
  Dio get dio => _dio;

  // static final HttpManager _singleton = HttpManager._init();
  // static HttpManager get instance => HttpManager();
  // factory HttpManager() => _singleton;
  static _init() async {
    final BaseOptions _options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      baseUrl: _baseUrl,
    );

    _dio = Dio(_options);

    // 网络连接拦截
    _interceptors.add(ConnectInterceptor(_dio));

    // token拦截
    _interceptors.add(TokenInterceptor(_dio));

    _interceptors.forEach((interceptor) {
      _dio.interceptors.add(interceptor);
    });

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

  static Future<CookieJar> get cookieJar async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + "/cookie/";
    CookieJar cj = PersistCookieJar(dir: tempPath, ignoreExpires: true);
    return cj;
  }

  // 数据返回格式统一，统一处理异常
  Future<ResultData> _request(
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
    } on DioError catch (e) {
      return ErrorHandler.handleException(e);
    }

    return response.data;
  }

  Options _checkOptions(String method, Options options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  Future requestNetwork<T>(
    Method method,
    String url, {
    HttpSuccessCallback<T> onSuccess,
    HttpErrorCallback onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    return _request(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ).then<void>((result) {
      if (result.code == 0) {
        if (onSuccess != null) {
          onSuccess(result.data);
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (dynamic e) {
      _cancelLogPrint(e, url);
      final ResultData error = ErrorHandler.handleException(e);
      _onError(error.code, error.message, onError);
    });
  }

  void asyncRequestNetwork<T>(
    Method method,
    String url, {
    HttpSuccessCallback<T> onSuccess,
    HttpErrorCallback onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    Stream.fromFuture(_request(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    )).asBroadcastStream().listen((result) {
      if (result.code == 0) {
        if (onSuccess != null) {
          onSuccess(result.data);
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (dynamic e) {
      _cancelLogPrint(e, url);
      final ResultData error = ErrorHandler.handleException(e);
      _onError(error.code, error.message, onError);
    });
  }

  void _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      LogUtils.e('取消请求接口： $url');
    }
  }

  void _onError(int code, String message, HttpErrorCallback onError) {
    if (code == null) {
      code = ErrorHandler.unknown_error;
      message = '未知异常';
    }
    LogUtils.e('接口请求异常： code: $code, mag: $message');
    if (onError != null) {
      onError(code, message);
    }
  }
}

enum Method { get, post, put, patch, delete, head }

/// 使用拓展枚举替代 switch判断取值
/// https://zhuanlan.zhihu.com/p/98545689
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
