import 'package:fluro/fluro.dart';
import 'package:flutter_demo/routes/i_router.dart';

import 'page/login_page.dart';
import 'page/register_page.dart';
import 'page/reset_pwd_page.dart';
import 'page/sms_login_page.dart';
import 'page/update_pwd_page.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = '/login';
  static String registerPage = '/login/register';
  static String smsLoginPage = '/login/smsLogin';
  static String resetPwdPage = '/login/resetPwd';
  static String updatePwdPage = '/login/updatePwd';

  @override
  void initRouter(Router router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, __) => LoginPage()));
    router.define(registerPage, handler: Handler(handlerFunc: (_, __) => RegisterPage()));
    router.define(smsLoginPage, handler: Handler(handlerFunc: (_, __) => SmsLoginPage()));
    router.define(resetPwdPage, handler: Handler(handlerFunc: (_, __) => ResetPwdPage()));
    router.define(updatePwdPage, handler: Handler(handlerFunc: (_, __) => UpdatePwdPage()));
  }
}
