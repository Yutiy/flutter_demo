import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/config.dart';
import 'package:flutter_demo/common/styles/gaps.dart';
import 'package:flutter_demo/common/styles/styles.dart';
import 'package:flutter_demo/localization/app_localizations.dart';
import 'package:flutter_demo/pages/login/login_router.dart';
import 'package:flutter_demo/pages/login/widget/my_text_field.dart';
import 'package:flutter_demo/pages/store/store_router.dart';
import 'package:flutter_demo/routes/fluro_navigator.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:flutter_demo/utils/utils.dart';
import 'package:flutter_demo/widget/chage_notifier_mixin.dart';
import 'package:flutter_demo/widget/my_app_bar.dart';
import 'package:flutter_demo/widget/my_button.dart';
import 'package:flutter_demo/widget/my_scroll_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with ChangeNotifierMixin<LoginPage> {
  //定义一个controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _nameController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = SpUtil.getString(Constant.phone);
  }

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _login() {
    SpUtil.putString(Constant.phone, _nameController.text);
    NavigatorUtils.push(context, Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: AppLocalizations.of(context).verificationCodeLogin,
        onPressed: () {
          NavigatorUtils.push(context, LoginRouter.smsLoginPage);
        },
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
          AppLocalizations.of(context).passwordLogin,
          style: TextStyles.textBold26,
        ),
        Gaps.vGap16,
        MyTextField(
          key: const Key('phone'),
          focusNode: _nodeText1,
          controller: _nameController,
          maxLength: 11,
          keyboardType: TextInputType.phone,
          hintText: AppLocalizations.of(context).inputPhoneHint,
        ),
        Gaps.vGap8,
        MyTextField(
          key: const Key('password'),
          keyName: 'password',
          focusNode: _nodeText2,
          isInputPwd: true,
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          maxLength: 16,
          hintText: AppLocalizations.of(context).inputPasswordHint,
        ),
        Gaps.vGap24,
        MyButton(
          key: const Key('login'),
          onPressed: _clickable ? _login : null,
          text: AppLocalizations.of(context).login,
        ),
        Container(
          height: 40.0,
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child: Text(
              AppLocalizations.of(context).forgotPasswordLink,
              key: const Key('forgotPassword'),
              style: Theme.of(context).textTheme.subtitle2,
            ),
            onTap: () => NavigatorUtils.push(context, LoginRouter.resetPwdPage),
          ),
        ),
        Gaps.vGap16,
        Container(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Text(
                AppLocalizations.of(context).noAccountRegisterLink,
                key: const Key('noAccountRegister'),
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
            ))
      ];
}
