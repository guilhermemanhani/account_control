import 'package:flutter/material.dart';

class DentrodobolsoDropDownButton extends StatelessWidget {
  final Widget widget;
  const DentrodobolsoDropDownButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 264,
      child: widget,
    );
  }
}
