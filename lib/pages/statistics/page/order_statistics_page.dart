import 'package:flutter/material.dart';

class OrderStatisticsPage extends StatefulWidget {
  const OrderStatisticsPage(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  _OrderStatisticsPageState createState() => _OrderStatisticsPageState();
}

class _OrderStatisticsPageState extends State<OrderStatisticsPage> {
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
