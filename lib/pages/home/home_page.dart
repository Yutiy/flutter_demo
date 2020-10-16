import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/common/styles/colors.dart';
import 'package:flutter_demo/common/styles/dimens.dart';
import 'package:flutter_demo/pages/goods/page/goods_page.dart';
import 'package:flutter_demo/pages/order/page/order_page.dart';
import 'package:flutter_demo/pages/shop/page/shop_page.dart';
import 'package:flutter_demo/pages/statistics/page/statistics_page.dart';
import 'package:flutter_demo/widget/double_tap_back_exit_app.dart';
import 'package:flutter_demo/widget/image_load.dart';
import 'package:flutter_demo/utils/theme_utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class HomeProvider extends ValueNotifier<int> {
  HomeProvider() : super(0);
}

class _HomeState extends State<Home> {
  static const double _imageSize = 25.0;

  List<Widget> _pageList;
  final List<String> _appBarTitles = ['订单', '商品', '统计', '店铺'];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;
  List<BottomNavigationBarItem> _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      OrderPage(),
      GoodsPage(),
      StatisticsPage(),
      ShopPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const _tabImages = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize, color: Colours.unselected_item_color),
          LoadAssetImage('home/icon_order', width: _imageSize, color: Colours.app_main),
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: Colours.unselected_item_color),
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: Colours.app_main),
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: Colours.unselected_item_color),
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: Colours.app_main),
        ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize, color: Colours.unselected_item_color),
          LoadAssetImage('home/icon_shop', width: _imageSize, color: Colours.app_main),
        ]
      ];
      _list = List.generate(_tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _list;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      const _tabImagesDark = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize),
          LoadAssetImage('home/icon_order', width: _imageSize, color: Colours.dark_app_main),
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize),
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: Colours.dark_app_main),
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize),
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: Colours.dark_app_main),
        ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize),
          LoadAssetImage('home/icon_shop', width: _imageSize, color: Colours.dark_app_main),
        ]
      ];

      _listDark = List.generate(_tabImagesDark.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImagesDark[i][0],
          activeIcon: _tabImagesDark[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _listDark;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return ChangeNotifierProvider<HomeProvider>(
        create: (_) => provider,
        child: DoubleTapBackExitApp(
            child: Scaffold(
                bottomNavigationBar: Consumer<HomeProvider>(
                  builder: (_, provider, __) {
                    return BottomNavigationBar(
                      backgroundColor: context.backgroundColor,
                      items: isDark ? _buildDarkBottomNavigationBarItem() : _buildBottomNavigationBarItem(),
                      type: BottomNavigationBarType.fixed,
                      currentIndex: provider.value,
                      elevation: 5.0,
                      iconSize: 21.0,
                      selectedFontSize: Dimens.font_sp10,
                      unselectedFontSize: Dimens.font_sp10,
                      selectedItemColor: Theme.of(context).primaryColor,
                      unselectedItemColor: isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
                      onTap: (index) => _pageController.jumpToPage(index),
                    );
                  },
                ),
                // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
                body: PageView(
                  physics: const NeverScrollableScrollPhysics(), // 禁止滑动
                  controller: _pageController,
                  onPageChanged: (int index) => provider.value = index,
                  children: _pageList,
                ))));
  }
}
