import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_demo/pages/login/login_router.dart';
import 'package:flutter_demo/routes/fluro_navigator.dart';
import 'package:flutter_demo/utils/image_utils.dart';
import 'package:flutter_demo/widget/image_load.dart';
import 'package:flutter_demo/common/config.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image, format: ImageFormat.webp), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  void _initSplash() {
    _subscription = Stream.value(1).delay(const Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        // color: context.backgroundColor,
        child: _status == 0
            ? FractionallyAlignedSizedBox(
                heightFactor: 0.3,
                widthFactor: 0.33,
                leftFactor: 0.33,
                bottomFactor: 0,
                child: const LoadAssetImage('logo'))
            : Swiper(
                key: const Key('swiper'),
                itemCount: _guideList.length,
                loop: false,
                itemBuilder: (_, index) {
                  return LoadAssetImage(
                    _guideList[index],
                    key: Key(_guideList[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    format: ImageFormat.webp,
                  );
                },
                onTap: (index) {
                  if (index == _guideList.length - 1) {
                    _goLogin();
                  }
                },
              ));
  }
}
