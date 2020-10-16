import 'package:flutter/material.dart';

class GoodsPage extends StatefulWidget {
  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with AutomaticKeepAliveClientMixin {
  int count = 0;

  @override
  void initState() {
    super.initState();
    print('goods initState');
  }

  void add() {
    setState(() {
      count++;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('First: $count', style: TextStyle(fontSize: 30))),
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: Icon(Icons.add),
        ));
  }
}
