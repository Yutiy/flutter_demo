import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_demo/common/net/result_data.dart';

class ConnectInterceptor extends Interceptor {
  final Dio _dio;

  ConnectInterceptor(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new ResultData());
    }

    return super.onRequest(options);
  }
}
