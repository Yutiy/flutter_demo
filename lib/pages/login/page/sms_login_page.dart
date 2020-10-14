import 'package:flutter/material.dart';

class SmsLoginPage extends StatefulWidget {
  @override
  _SmsLoginPage createState() => _SmsLoginPage();
}

class _SmsLoginPage extends State<SmsLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('SmsLoginPage Page'),
      ),
      body: Text('smsLoginPage'),
    );
  }
}
