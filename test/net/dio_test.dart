import 'package:dio/dio.dart';
import 'package:flutter_demo/common/net/net.dart';
import 'package:test/test.dart';

void main() {
  group('dio_test', () {
    Dio dio;
    setUp(() {
      /// 测试配置
      dio = HttpManager.instance.dio;
      dio.options.baseUrl = 'https://api.github.com/';
    });

    test('getUsers', () async {
      await HttpManager.instance.requestNetwork(Method.get, 'users/Yutiy', onSuccess: (data) {
        expect(data.name, 'Yutiy');
      }, onError: (_, __) {
        print('$_, $__');
      });
    });
  });
}
