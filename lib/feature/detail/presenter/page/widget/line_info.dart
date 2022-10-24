import 'package:flutter/material.dart';

import '../../../../../core/ui/extensions/theme_extension.dart';

class LineInfo extends StatelessWidget {
  final IconData iconOne;
  final IconData iconTwo;
  final String textOne;
  final String textTwo;

  const LineInfo({
    Key? key,
    required this.iconOne,
    required this.iconTwo,
    required this.textOne,
    required this.textTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              iconOne,
              color: context.darkBlue,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              textOne,
              style: TextStyle(
                color: context.darkBlue,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Icon(
              iconTwo,
              color: context.darkBlue,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              textTwo.isEmpty ? "Não informado" : textTwo,
              style: TextStyle(
                color: context.darkBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
