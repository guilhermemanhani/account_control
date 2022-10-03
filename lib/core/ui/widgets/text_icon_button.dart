import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final double width;
  final GestureTapCallback onTap;

  const TextIconButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(blurRadius: 4)]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
                right: 2,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 16,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: VerticalDivider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
