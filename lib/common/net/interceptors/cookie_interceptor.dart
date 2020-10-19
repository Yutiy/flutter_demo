import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class CookieInterceptor extends Interceptor {
  final CookieJar cookieJar;

  CookieInterceptor(this.cookieJar);

  // Directory tempDir = await getTemporaryDirectory();
  // String tempPath = tempDir.path + "/dioCookie";
  // print('DioUtil : http cookie path = $tempPath');
  // CookieJar cj = PersistCookieJar(dir: tempPath, ignoreExpires: true);
  // dio.interceptors.add(CookieInterceptor(cj));

  @override
  Future onRequest(RequestOptions options) async {
    var cookies = cookieJar.loadForRequest(options.uri);
    cookies.removeWhere((cookie) {
      if (cookie.expires != null) {
        return cookie.expires.isBefore(DateTime.now());
      }
      return false;
    });
    String cookie = getCookies(cookies);
    if (cookie.isNotEmpty) options.headers[HttpHeaders.cookieHeader] = cookie;
  }

  @override
  Future onResponse(Response response) async => _saveCookies(response);

  @override
  Future onError(DioError err) async => _saveCookies(err.response);

  _saveCookies(Response response) {
    if (response != null && response.headers != null) {
      String uri = response.request.uri.toString();
      List<String> cookies = response.headers[HttpHeaders.setCookieHeader];
      if (cookies != null &&
          (uri.contains(Constants.SAVE_USER_LOGIN_KEY) ||
              uri.contains(Constants.SAVE_USER_REGISTER_KEY))) {
        cookieJar.saveFromResponse(
          response.request.uri,
          cookies.map((str) => Cookie.fromSetCookieValue(str)).toList(),
        );
      }
    }
}