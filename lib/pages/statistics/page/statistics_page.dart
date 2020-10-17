import 'package:flutter/material.dart';
import 'package:flutter_demo/bloc/bloc_provider.dart';
import 'package:flutter_demo/bloc/count_bloc.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Widget build(BuildContext context) {
    CountBloc _bloc = BlocProvider.of<CountBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("CountBloc"),
        ),
        body: StreamBuilder<int>(
            stream: _bloc.value,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Center(
                  child: Text('You hit me: ${snapshot.data.toString()} times',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300)));
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: _bloc.increment,
          child: Icon(Icons.add),
        ));
  }
}
