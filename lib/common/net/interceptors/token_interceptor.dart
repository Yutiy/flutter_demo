import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter_demo/common/config.dart';
import 'package:flutter_demo/utils/log_utils.dart';
import 'package:flutter_demo/common/net/error_handler.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;

  TokenInterceptor(this._dio);

  Future<String> getToken() async {
    final Map<String, String> params = <String, String>{};
    params['refresh_token'] = SpUtil.getString(Constant.refreshToken);
    try {
      final Response response = await _dio.post<dynamic>('lgn/refreshToken', data: params);
      if (response.statusCode == ExceptionHandle.success) {
        return json.decode(response.data.toString())['access_token'] as String;
      }
    } catch (e) {
      LogUtils.e('刷新Token失败！');
    }
    return null;
  }

  @override
  Future onRequest(RequestOptions options) {
    final String accessToken = SpUtil.getString(Constant.accessToken);
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'token $accessToken';
    }
    // https://developer.github.com/v3/#user-agent-required
    options.headers['User-Agent'] = 'Mozilla/5.0';
    return super.onRequest(options);
  }

  @override
  Future<Object> onResponse(Response response) async {
    //401代表token过期
    if (response != null && response.statusCode == ExceptionHandle.unauthorized) {
      LogUtils.d('-----------自动刷新Token------------');
      _dio.interceptors.requestLock.lock();
      final String accessToken = await getToken(); // 获取新的accessToken
      LogUtils.e('-----------NewToken: $accessToken ------------');
      SpUtil.putString(Constant.accessToken, accessToken);
      _dio.interceptors.requestLock.unlock();

      if (accessToken != null) {
        // 重新请求失败接口
        final RequestOptions request = response.request;
        request.headers['Authorization'] = 'Bearer $accessToken';
        try {
          LogUtils.e('----------- 重新请求接口 ------------');

          /// 避免重复执行拦截器，使用tokenDio
          final Response response = await _dio.request<dynamic>(request.path,
              data: request.data,
              queryParameters: request.queryParameters,
              cancelToken: request.cancelToken,
              options: request,
              onReceiveProgress: request.onReceiveProgress);
          return response;
        } on DioError catch (e) {
          return e;
        }
      }
    }
    return super.onResponse(response);
  }
}
