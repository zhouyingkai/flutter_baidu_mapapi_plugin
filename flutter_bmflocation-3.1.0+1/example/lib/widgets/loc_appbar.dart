import 'package:flutter/material.dart';

class Constants {
  static const String actionBarColor = '0xFF1F2131';
  static const String controlBarColor = '0xD91F2131';
  static const String btnColor = '0xD9292B3C';
}

class BMFAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BMFAppBar(
      {Key? key,
      this.title,
      this.titleStyle,
      this.backgroundColor,
      this.isBack = true,
      this.onBack,
      this.actions,
      this.bottom})
      : super(key: key);

  /// 标题
  final String? title;

  /// 标题Style
  final TextStyle? titleStyle;

  /// 背景色
  final Color? backgroundColor;

  /// 是否展示返回按钮
  final bool isBack;

  /// 返回按钮点击回调
  final VoidCallback? onBack;

  /// actions
  final List<Widget>? actions;

  /// 底部widget
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? 'title',
        style: titleStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
      ),
      leading: isBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios), onPressed: onBack)
          : null,
      actions: actions,
      backgroundColor:
          backgroundColor ?? Color(int.parse(Constants.actionBarColor)),
      elevation: 0,
      bottom: BMFAppBarBottom(child: bottom),
    );
  }
}

class BMFAppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const BMFAppBarBottom({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: double.infinity,
        height: 0,
        color: Colors.white,
      ),
      child ?? const SizedBox(height: 0),
    ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(child != null ? 47 : 1);
}
