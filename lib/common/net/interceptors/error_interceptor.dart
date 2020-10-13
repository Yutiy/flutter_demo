import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_demo/common/net/result_data.dart';

class ErrorInterceptor extends Interceptor {
  final Dio _dio;

  ErrorInterceptor(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new ResultData('', 111, '111'));
    }

    return super.onRequest(options);
  }
}
