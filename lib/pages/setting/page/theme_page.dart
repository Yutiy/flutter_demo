import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/config.dart';
import 'package:flutter_demo/common/provider/theme_provider.dart';
import 'package:flutter_demo/widget/my_app_bar.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePage createState() => _ThemePage();
}

class _ThemePage extends State<ThemePage> {
  final List<String> _list = ['跟随系统', '开启', '关闭'];

  @override
  Widget build(BuildContext context) {
    final String theme = SpUtil.getString(Constant.theme);
    String themeMode;
    switch (theme) {
      case 'Dark':
        themeMode = _list[1];
        break;
      case 'Light':
        themeMode = _list[2];
        break;
      default:
        themeMode = _list[0];
        break;
    }

    return Scaffold(
      appBar: MyAppBar(
        title: '夜间模式',
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (_, index) => const Divider(),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              final ThemeMode themeMode =
                  index == 0 ? ThemeMode.system : (index == 1 ? ThemeMode.dark : ThemeMode.light);

              /// Provider.of<ThemeProvider>(context, listen: false).setTheme(themeMode);
              /// 与上方等价，provider 4.1.0添加的拓展方法
              context.read<ThemeProvider>().setTheme(themeMode);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_list[index]),
                  ),
                  Opacity(
                    opacity: themeMode == _list[index] ? 1 : 0,
                    child: const Icon(Icons.done, color: Colors.blue),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
