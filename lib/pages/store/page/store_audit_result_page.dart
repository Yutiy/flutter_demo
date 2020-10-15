import 'package:flutter/material.dart';
import 'package:flutter_demo/common/styles/gaps.dart';
import 'package:flutter_demo/common/styles/styles.dart';
import 'package:flutter_demo/routes/fluro_navigator.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:flutter_demo/widget/image_load.dart';
import 'package:flutter_demo/widget/my_app_bar.dart';
import 'package:flutter_demo/widget/my_button.dart';

class StoreAuditResultPage extends StatefulWidget {
  @override
  _StoreAuditResultPage createState() => _StoreAuditResultPage();
}

class _StoreAuditResultPage extends State<StoreAuditResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '审核结果',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap50,
            const LoadAssetImage(
              'store/icon_success',
              width: 80.0,
              height: 80.0,
            ),
            Gaps.vGap12,
            const Text(
              '恭喜，店铺资料审核成功',
              style: TextStyles.textSize16,
            ),
            Gaps.vGap8,
            Text(
              '2020-02-21 15:20:10',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Gaps.vGap8,
            Text(
              '预计完成时间：02月28日',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Gaps.vGap24,
            MyButton(
              onPressed: () {
                NavigatorUtils.push(context, Routes.home, clearStack: true);
              },
              text: '进入',
            )
          ],
        ),
      ),
    );
  }
}
