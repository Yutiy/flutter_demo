import 'package:fluro/fluro.dart';
import 'package:flutter_demo/routes/i_router.dart';

import 'page/goods_page.dart';

class GoodsRouter implements IRouterProvider {
  static String goodsPage = '/goods';

  @override
  void initRouter(Router router) {
    router.define(goodsPage, handler: Handler(handlerFunc: (_, __) => GoodsPage()));
  }
}
