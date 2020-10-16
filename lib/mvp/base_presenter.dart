import 'package:flutter_demo/mvp/mvps.dart';

class BasePresenter<V extends IMvpView> extends IPresenter {
  V view;

  /// 当Widget第一次插入到Widget树时会被调用
  @override
  void initState() {}

  /// 当State对象的依赖发生变化时会被调用
  @override
  void didChangeDependencies() {}

  /// 当Widget重新构建时
  @override
  void didUpdateWidgets<V>(V oldWidget) {}

  /// 当State对象从树中被移除时
  @override
  void deactivate() {}

  /// 当State对象从树中被永久移除时调用
  @override
  void dispose() {}
}
