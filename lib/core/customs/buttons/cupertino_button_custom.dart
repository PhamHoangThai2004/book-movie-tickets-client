import 'package:flutter/cupertino.dart';

class CupertinoButtonCustom extends StatelessWidget {
  const CupertinoButtonCustom({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
  });

  final Function()? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding ?? EdgeInsets.zero,
      minimumSize: Size(0, 0),
      onPressed: onPressed,
      child: child,
    );
  }
}
