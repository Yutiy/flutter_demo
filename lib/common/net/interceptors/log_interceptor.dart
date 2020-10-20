import "package:dio/dio.dart";
import 'package:flutter_demo/utils/log_utils.dart';
import 'package:flutter_demo/common/net/error_handler.dart';

class LogInterceptor extends Interceptor {
  DateTime _startTime;
  DateTime _endTime;

  @override
  Future onRequest(RequestOptions options) {
    _startTime = DateTime.now();
    LogUtils.d('----------Start----------');
    if (options.queryParameters.isEmpty) {
      LogUtils.d('RequestUrl: ' + options.baseUrl + options.path);
    } else {
      LogUtils.d(
          'RequestUrl: ' + options.baseUrl + options.path + '?' + Transformer.urlEncodeMap(options.queryParameters));
    }
    LogUtils.d('RequestMethod: ' + options.method);
    LogUtils.d('RequestHeaders:' + options.headers.toString());
    LogUtils.d('RequestContentType: ${options.contentType}');
    LogUtils.d('RequestData: ${options.data.toString()}');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    if (response.statusCode == ErrorHandler.success) {
      LogUtils.d('ResponseCode: ${response.statusCode}');
    } else {
      LogUtils.e('ResponseCode: ${response.statusCode}');
    }
    // 输出结果
    LogUtils.json(response.data.toString());
    LogUtils.d('----------End: $duration 毫秒----------');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    LogUtils.d('----------Error-----------');
    return super.onError(err);
  }
}
