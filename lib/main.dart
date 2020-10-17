import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/common/provider/theme_provider.dart';
import 'package:flutter_demo/localization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:flutter_demo/utils/device_utils.dart';
import 'package:flutter_demo/pages/not_found_page.dart';
import 'package:flutter_demo/pages/splash_page.dart';

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
  final ThemeData theme;

  MyApp({this.home, this.theme}) {
    LogUtil.init();
    Routes.initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
            child: Consumer<ThemeProvider>(builder: (_, provider, __) {
              return new MaterialApp(
                title: 'Flutter Demo',
                // showPerformanceOverlay: true, //显示性能标签
                // debugShowCheckedModeBanner: false, // 去除右上角debug的标签
                // checkerboardRasterCacheImages: true,
                // showSemanticsDebugger: true, // 显示语义视图
                // checkerboardOffscreenLayers: true, // 检查离屏渲染
                theme: theme ?? provider.getTheme(),
                darkTheme: provider.getTheme(isDarkMode: true),
                themeMode: provider.getThemeMode(),
                home: home ?? SplashPage(),
                onGenerateRoute: Routes.router.generator,
                localizationsDelegates: [
                  // 注册我们的Delegate
                  AppLocalizationsDelegate(),
                  // 本地化的代理类
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const <Locale>[Locale('zh', 'CN'), Locale('en', 'US')],
                builder: (context, child) {
                  /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child,
                  );
                },

                /// 因为使用了fluro，这里设置主要针对Web
                onUnknownRoute: (_) {
                  return MaterialPageRoute<void>(
                    builder: (BuildContext context) => NotFoundPage(),
                  );
                },
              );
            })),

        /// Toast 配置
        backgroundColor: Colors.black54,
        textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.center);
  }
}
