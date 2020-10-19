import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/common/styles/gaps.dart';
import 'package:flutter_demo/routes/fluro_navigator.dart';
import 'package:flutter_demo/widget/click_item.dart';
import 'package:flutter_demo/widget/my_app_bar.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _styles = [FlutterLogoStyle.stacked, FlutterLogoStyle.markOnly, FlutterLogoStyle.horizontal];
  final _curves = [
    Curves.ease,
    Curves.easeIn,
    Curves.easeInOutCubic,
    Curves.easeInOut,
    Curves.easeInQuad,
    Curves.easeInCirc,
    Curves.easeInBack,
    Curves.easeInOutExpo,
    Curves.easeInToLinear,
    Curves.easeOutExpo,
    Curves.easeInOutSine,
    Curves.easeOutSine,
  ];

  // 取随机颜色
  Color _randomColor() {
    final red = Random.secure().nextInt(255);
    final greed = Random.secure().nextInt(255);
    final blue = Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }

  Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 2s定时器
      _countdownTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        // https://www.jianshu.com/p/e4106b829bff
        if (!mounted) {
          return;
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: '关于我们',
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap50,
          FlutterLogo(
            size: 100.0,
            textColor: _randomColor(),
            style: _styles[Random.secure().nextInt(3)],
            curve: _curves[Random.secure().nextInt(12)],
          ),
          Gaps.vGap10,
          ClickItem(
              title: 'Github',
              content: 'Go Star',
              onTap: () =>
                  NavigatorUtils.goWebViewPage(context, 'Flutter Deer', 'https://github.com/simplezhli/flutter_deer')),
          ClickItem(
              title: '作者', onTap: () => NavigatorUtils.goWebViewPage(context, '作者博客', 'https://www.ytxcloud.com')),
        ],
      ),
    );
  }
}
