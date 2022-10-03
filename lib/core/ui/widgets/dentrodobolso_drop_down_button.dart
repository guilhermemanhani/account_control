import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class DentrodobolsoDropDownButton extends StatelessWidget {
  final Widget widget;
  const DentrodobolsoDropDownButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: context.lightGrey, width: 1),
      ),
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 4),
        child: widget,
      ),
    );
  }
}
