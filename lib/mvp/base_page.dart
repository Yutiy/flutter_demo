import 'package:flutter/material.dart';
import 'package:flutter_demo/mvp/base_presenter.dart';
import 'package:flutter_demo/mvp/mvps.dart';
import 'package:flutter_demo/utils/log_utils.dart';

import '../routes/fluro_navigator.dart';
import '../utils/toast_utils.dart';

mixin BasePageMixin<T extends StatefulWidget, P extends BasePresenter> on State<T> implements IMvpView {
  P presenter;
  P createPresenter();

  bool _isShowDialog = false;

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  @override
  void showToast(String string) {
    ToastUtils.show(string);
  }

  @override
  void initState() {
    LogUtils.d('$T ==> initState');
    presenter = createPresenter();
    presenter?.view = this;
    presenter?.initState();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    presenter?.didChangeDependencies();
    LogUtils.d('$T ==> didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    presenter?.didUpdateWidgets<T>(oldWidget);
    LogUtils.d('$T ==> didUpdateWidgets');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    presenter?.deactivate();
    LogUtils.d('$T ==> deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    presenter?.dispose();
    LogUtils.d('$T ==> dispose');
    super.dispose();
  }
}
