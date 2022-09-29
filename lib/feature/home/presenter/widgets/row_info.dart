import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final String title;
  final String value;
  final Color colorText;
  const RowInfo({
    Key? key,
    required this.title,
    required this.value,
    this.colorText = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 100,
            ),
            child: Text(
              value,
              style: TextStyle(
                color: value.contains('-') ? Colors.red : colorText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
