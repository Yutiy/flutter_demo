import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UpdateDialog extends StatefulWidget {
  @override
  _UpdateDialog createState() => _UpdateDialog();
}

class _UpdateDialog extends State<UpdateDialog> {
  final CancelToken _cancelToken = CancelToken();
  bool _isDownload = false;
  double _value = 0;

  @override
  void dispose() {
    if (!_cancelToken.isCancelled && _value != 1) {
      _cancelToken.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
