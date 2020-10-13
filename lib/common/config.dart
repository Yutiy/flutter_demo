import 'package:flutter/foundation.dart';

class Constant {
  static const String data = 'data';
  static const String code = 'code';
  static const String message = 'message';

  static const String phone = 'phone';
  static const String keyGuide = 'keyGuide';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';
}

class AppConfig {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;
  static const bool isDebug = kDebugMode;

  static bool isUnitTest = false;
  static bool isDriverTest = false;

  static const String version = '0.0.1';
  static const String appName = 'flutter_demo';
  static const String appId = 'com.flutter.flutterdemo';
}
