import 'package:fluro/fluro.dart';
import 'package:flutter_demo/routes/i_router.dart';

import 'page/shop_page.dart';

class ShopRouter implements IRouterProvider {
  static String shopPage = '/shop';

  @override
  void initRouter(Router router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, __) => ShopPage()));
  }
}
