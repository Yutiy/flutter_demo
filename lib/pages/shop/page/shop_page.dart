import 'package:flutter/material.dart';
import 'package:flutter_demo/common/styles/gaps.dart';
import 'package:flutter_demo/common/styles/styles.dart';
import 'package:flutter_demo/pages/setting/setting_router.dart';
import 'package:flutter_demo/routes/fluro_navigator.dart';
import 'package:flutter_demo/utils/image_utils.dart';
import 'package:flutter_demo/utils/theme_utils.dart';
import 'package:flutter_demo/widget/image_load.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({
    Key key,
    this.isAccessibilityTest = false,
  }) : super(key: key);

  final bool isAccessibilityTest;

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with AutomaticKeepAliveClientMixin<ShopPage> {
  final List<String> _menuTitle = ['账户流水', '资金管理', '提现账号'];
  final List<String> _menuImage = ['zhls', 'zjgl', 'txzh'];
  final List<String> _menuDarkImage = ['dark_zhls', 'dark_zjgl', 'dark_txzh'];

  int count = 0;

  @override
  bool get wantKeepAlive => true;

  bool get isAccessibilityTest => widget.isAccessibilityTest;

  @override
  Widget build(BuildContext context) {
    final Color _iconColor = ThemeUtils.getIconColor(context);
    final Widget line = Container(
      height: 0.6,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16.0),
      child: Gaps.line,
    );

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              tooltip: '消息',
              onPressed: () {
                // NavigatorUtils.push(context, ShopRouter.messagePage);
              },
              icon: LoadAssetImage(
                'shop/message',
                key: const Key('message'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            ),
            IconButton(
              tooltip: '设置',
              onPressed: () {
                NavigatorUtils.push(context, SettingRouter.settingPage);
              },
              icon: LoadAssetImage(
                'shop/setting',
                key: const Key('setting'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gaps.vGap12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MergeSemantics(
                child: Stack(
                  children: <Widget>[
                    const SizedBox(width: double.infinity, height: 56.0),
                    const Text(
                      '官方直营店',
                      style: TextStyles.textBold24,
                    ),
                    Positioned(
                      right: 0.0,
                      child: CircleAvatar(
                        radius: 28.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: ImageUtils.getImageProvider(null, holderImg: 'shop/tx'),
                      ),
                    ),
                    Positioned(
                      top: 38.0,
                      left: 0.0,
                      child: Row(
                        children: const <Widget>[
                          LoadAssetImage(
                            'shop/zybq',
                            width: 40.0,
                            height: 16.0,
                          ),
                          Gaps.hGap8,
                          Text('店铺账号:15000000000', style: TextStyles.textSize12)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.vGap24,
            line,
            Gaps.vGap24,
            MergeSemantics(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('账户', style: TextStyles.textBold18),
              ),
            ),
            _ShopFunctionModule(
              data: _menuTitle,
              image: _menuImage,
              darkImage: _menuDarkImage,
              onItemClick: (index) {
                if (index == 0) {
                  // NavigatorUtils.push(context, AccountRouter.accountRecordListPage);
                } else if (index == 1) {
                  // NavigatorUtils.push(context, AccountRouter.accountPage);
                } else if (index == 2) {
                  // NavigatorUtils.push(context, AccountRouter.withdrawalAccountPage);
                }
              },
            ),
            line,
            Gaps.vGap24,
            const MergeSemantics(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '店铺',
                  style: TextStyles.textBold18,
                ),
              ),
            ),
            Flexible(
              child: _ShopFunctionModule(
                data: const ['店铺设置'],
                image: const ['dpsz'],
                darkImage: const ['dark_dpsz'],
                onItemClick: (index) {
                  // NavigatorUtils.push(context, ShopRouter.shopSettingPage);
                },
              ),
            ),
          ],
        ));
  }
}

class _ShopFunctionModule extends StatelessWidget {
  const _ShopFunctionModule({
    Key key,
    this.onItemClick,
    @required this.data,
    @required this.image,
    @required this.darkImage,
  }) : super(key: key);

  final List<String> data;
  final List<String> image;
  final List<String> darkImage;
  final Function(int index) onItemClick;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.18,
      ),
      itemCount: data.length,
      itemBuilder: (_, index) {
        return InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage(context.isDark ? 'shop/${darkImage[index]}' : 'shop/${image[index]}', width: 32.0),
              Gaps.vGap4,
              Text(
                data[index],
                style: TextStyles.textSize12,
              )
            ],
          ),
          onTap: () {
            onItemClick(index);
          },
        );
      },
    );
  }
}
