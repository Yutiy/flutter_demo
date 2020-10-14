import 'package:flutter/material.dart';

class ResetPwdPage extends StatefulWidget {
  @override
  _ResetPwdPage createState() => _ResetPwdPage();
}

class _ResetPwdPage extends State<ResetPwdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('ResetPwd Page'),
      ),
      body: Text('resetPwd'),
    );
  }
}
