import 'package:fluro/fluro.dart';
import 'package:flutter_demo/routes/i_router.dart';

import 'page/shop_page.dart';
import 'page/message_page.dart';

class ShopRouter implements IRouterProvider {
  static String shopPage = '/shop';
  static String messagePage = '/message';

  @override
  void initRouter(Router router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, __) => ShopPage()));
    router.define(messagePage, handler: Handler(handlerFunc: (_, __) => MessagePage()));
  }
}
