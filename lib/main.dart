import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_util/sp_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_demo/routes/not_found_page.dart';
import 'package:flutter_demo/routes/routes.dart';
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
    const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final Widget home;

  MyApp({this.home}) {
    LogUtil.init();
    Routes.initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      // showPerformanceOverlay: true, //显示性能标签
      // debugShowCheckedModeBanner: false, // 去除右上角debug的标签
      // checkerboardRasterCacheImages: true,
      // showSemanticsDebugger: true, // 显示语义视图
      // checkerboardOffscreenLayers: true, // 检查离屏渲染
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home ?? SplashPage(),
      onGenerateRoute: Routes.router.generator,
      supportedLocales: const <Locale>[Locale('zh', 'CN'), Locale('en', 'US')],

      /// 因为使用了fluro，这里设置主要针对Web
      onUnknownRoute: (_) {
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => NotFoundPage(),
        );
      },
    );
  }
}
