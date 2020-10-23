import 'package:fluro/fluro.dart';
import 'package:flutter_demo/pages/account/page/account_page.dart';
import 'package:flutter_demo/routes/i_router.dart';

class AccountRouter implements IRouterProvider {
  static String accountPage = '/account';

  @override
  void initRouter(Router router) {
    router.define(accountPage, handler: Handler(handlerFunc: (_, __) => AccountPage()));
  }
}
