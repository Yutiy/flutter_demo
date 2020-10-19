import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/config.dart';
import 'package:flutter_demo/common/styles/gaps.dart';
import 'package:flutter_demo/pages/setting/setting_router.dart';
import 'package:flutter_demo/pages/setting/widget/exit_dialog.dart';
import 'package:flutter_demo/pages/setting/widget/update_dialog.dart';
import 'package:flutter_demo/routes/fluro_navigator.dart';
import 'package:flutter_demo/widget/click_item.dart';
import 'package:flutter_demo/widget/my_app_bar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final String theme = SpUtil.getString(Constant.theme);
    String themeMode;
    switch (theme) {
      case 'Dark':
        themeMode = '开启';
        break;
      case 'Light':
        themeMode = '关闭';
        break;
      default:
        themeMode = '跟随系统';
        break;
    }

    return Scaffold(
      appBar: MyAppBar(centerTitle: '设置'),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(title: '账号管理', onTap: () => NavigatorUtils.push(context, SettingRouter.accountManagerPage)),
          ClickItem(title: '清除缓存', content: '23.5MB', onTap: () {}),
          ClickItem(
              title: '夜间模式', content: themeMode, onTap: () => NavigatorUtils.push(context, SettingRouter.themePage)),
          ClickItem(
            title: '检查更新',
            onTap: _showUpdateDialog,
          ),
          ClickItem(title: '关于我们', onTap: () => NavigatorUtils.push(context, SettingRouter.aboutPage)),
          ClickItem(
            title: '退出当前账号',
            onTap: _showExitDialog,
          ),
          ClickItem(
            title: '其他Demo',
            // onTap: () => AppNavigator.push(context, DemoPage()),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => UpdateDialog(),
    );
  }

  void _showExitDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => ExitDialog(),
    );
  }
}
