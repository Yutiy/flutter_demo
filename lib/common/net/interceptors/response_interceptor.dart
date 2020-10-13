import "package:dio/dio.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter_demo/common/net/result_data.dart';

class ResponseInterceptor extends Interceptor {
  @override
  Future onResponse(Response response) {
    RequestOptions option = response.request;
    var value;

    try {
      var header = response.headers[Headers.contentTypeHeader];
      if (header != null && header.toString().contains("text")) {
        value =
            new ResultData(response.data, response.statusCode, response.data);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value =
            new ResultData(response.data, response.statusCode, response.data);
      }
    } catch (e) {
      debugPrint(e.toString() + option.path);
      value = new ResultData(response.data, response.statusCode, response.data);
    }

    return super.onResponse(value);
  }
}
