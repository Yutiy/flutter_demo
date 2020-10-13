import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter_demo/utils/device_utils.dart';
import 'package:flutter_demo/pages/home/splash_page.dart';

Future<void> main() async {
  // debugProfileBuildsEnabled = true;
  // debugPaintLayerBordersEnabled = true;
  // debugProfilePaintsEnabled = true;
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  /// sp初始化
  await SpUtil.getInstance();
  runApp(MyApp());
  // 透明状态栏
  if (DeviceUtils.isAndroid) {
    const SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final Widget home;

  MyApp({this.home}) {
    LogUtil.init();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
