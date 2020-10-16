import 'package:flutter/material.dart';

class GoodsStatisticsPage extends StatefulWidget {
  @override
  _GoodsStatisticsPageState createState() => _GoodsStatisticsPageState();
}

class _GoodsStatisticsPageState extends State<GoodsStatisticsPage> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    print('statistics initState');
  }

  void add() {
    setState(() {
      count++;
    });
  }

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
