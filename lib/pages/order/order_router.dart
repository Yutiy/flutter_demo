import 'package:fluro/fluro.dart';
import 'package:flutter_demo/routes/i_router.dart';

import 'page/order_page.dart';

class OrderRouter implements IRouterProvider {
  static String orderPage = '/order';

  @override
  void initRouter(Router router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, __) => OrderPage()));
  }
}
