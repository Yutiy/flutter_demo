import 'dart:async';

import 'bloc_provider.dart';

class CountBloc implements BlocBase {
  int _count;
  StreamController<int> _countController;

  CountBloc() {
    _count = 0;
    _countController = StreamController<int>();
  }

  Stream<int> get value => _countController.stream;

  void increment() {
    _countController.sink.add(++_count);
  }

  void dispose() {
    _countController.close();
  }
}
