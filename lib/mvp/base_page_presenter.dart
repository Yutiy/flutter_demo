import 'package:dio/dio.dart';
import 'package:flutter_demo/mvp/base_presenter.dart';
import 'package:flutter_demo/mvp/mvps.dart';

class BasePagePresenter<V extends IMvpView> extends BasePresenter<V> {
  CancelToken _cancelToken;

  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void dispose() {
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
