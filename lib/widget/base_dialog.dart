import 'package:flutter/material.dart';
import 'package:flutter_demo/common/styles/colors.dart';
import 'package:flutter_demo/common/styles/dimens.dart';
import 'package:flutter_demo/common/styles/gaps.dart';
import 'package:flutter_demo/common/styles/styles.dart';
import 'package:flutter_demo/routes/fluro_navigator.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({Key key, this.title, this.onPressed, this.hiddenTitle = false, @required this.child})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    final Widget dialogTitle = Visibility(
      visible: !hiddenTitle,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          hiddenTitle ? '' : title,
          style: TextStyles.textBold18,
        ),
      ),
    );

    final Widget bottomButton = Row(
      children: <Widget>[
        _DialogButton(
          text: '取消',
          textColor: Colours.text_gray,
          onPressed: () => NavigatorUtils.goBack(context),
        ),
        const SizedBox(
          height: 48.0,
          width: 0.6,
          child: VerticalDivider(),
        ),
        _DialogButton(
          text: '确定',
          textColor: Theme.of(context).primaryColor,
          onPressed: onPressed,
        ),
      ],
    );

    final Widget body = Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap24,
          dialogTitle,
          Flexible(child: child),
          Gaps.vGap8,
          Gaps.line,
          bottomButton,
        ],
      ),
    );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(microseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 270.0,
            child: body,
          ),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    Key key,
    this.text,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48.0,
        child: FlatButton(
          child: Text(
            text,
            style: const TextStyle(fontSize: Dimens.font_sp18),
          ),
          textColor: textColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
