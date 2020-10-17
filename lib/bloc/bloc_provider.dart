import 'package:flutter/material.dart';

abstract class BlocBase {
  // 释放
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc; // bloc
  final Widget child; // 子Widget

  BlocProvider({Key key, @required this.bloc, @required this.child}) : super(key: key);

  // 通过 getElementForInheritedWidgetOfExactType 获取 bloc 实例
  static T of<T extends BlocBase>(BuildContext context) {
    _BlocProviderInherited<T> provider =
        context.getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()?.widget;
    return provider?.bloc;
  }

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new _BlocProviderInherited<T>(
      child: widget.child,
      bloc: widget.bloc,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
