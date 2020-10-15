import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/common/styles/dimens.dart';
import 'package:flutter_demo/common/styles/gaps.dart';
import 'package:flutter_demo/common/styles/styles.dart';
import 'package:flutter_demo/localization/app_localizations.dart';
import 'package:flutter_demo/pages/login/login_router.dart';
import 'package:flutter_demo/pages/login/widget/my_text_field.dart';
import 'package:flutter_demo/routes/fluro_navigator.dart';
import 'package:flutter_demo/utils/toast_utils.dart';
import 'package:flutter_demo/utils/utils.dart';
import 'package:flutter_demo/widget/chage_notifier_mixin.dart';
import 'package:flutter_demo/widget/my_app_bar.dart';
import 'package:flutter_demo/widget/my_button.dart';
import 'package:flutter_demo/widget/my_scroll_view.dart';

class SmsLoginPage extends StatefulWidget {
  @override
  _SmsLoginPage createState() => _SmsLoginPage();
}

class _SmsLoginPage extends State<SmsLoginPage> with ChangeNotifierMixin<SmsLoginPage> {
  //定义一个controller
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _phoneController: callbacks,
      _vCodeController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String name = _phoneController.text;
    final String vCode = _vCodeController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _login() {
    ToastUtils.show('去登录......');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: true,
      ),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2]),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody,
      ),
    );
  }

  List<Widget> get _buildBody => <Widget>[
        Text(
          AppLocalizations.of(context).verificationCodeLogin,
          style: TextStyles.textBold26,
        ),
        Gaps.vGap16,
        MyTextField(
          key: const Key('phone'),
          focusNode: _nodeText1,
          controller: _phoneController,
          maxLength: 11,
          keyboardType: TextInputType.phone,
          hintText: AppLocalizations.of(context).inputPhoneHint,
        ),
        Gaps.vGap8,
        MyTextField(
          key: const Key('code'),
          focusNode: _nodeText2,
          controller: _vCodeController,
          maxLength: 6,
          keyboardType: TextInputType.number,
          hintText: AppLocalizations.of(context).inputVerificationCodeHint,
          getVCode: () {
            ToastUtils.show('获取验证码');
            return Future.value(true);
          },
        ),
        Gaps.vGap8,
        Container(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context).registeredTips,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp14),
                  children: <TextSpan>[
                    TextSpan(
                        text: AppLocalizations.of(context).register,
                        style: TextStyle(color: Theme.of(context).errorColor)),
                    TextSpan(text: window.locale.languageCode == 'zh' ? '。' : '.'),
                  ],
                ),
              ),
              onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
            )),
        Gaps.vGap24,
        MyButton(
          onPressed: _clickable ? _login : null,
          text: AppLocalizations.of(context).login,
        ),
        Container(
          height: 40.0,
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child: Text(
              AppLocalizations.of(context).forgotPasswordLink,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            onTap: () => NavigatorUtils.push(context, LoginRouter.resetPwdPage),
          ),
        )
      ];
}
