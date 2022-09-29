import 'package:flutter/material.dart';

class HeadHome extends StatelessWidget {
  final String value;
  const HeadHome({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.blueGrey,
          ],
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 30,
              // top: 1.statusBarHeight + 30,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            height: 80,
            // child: Observer(
            //   builder: (_) {
            //     return Column(
            //       children: [
            //         const Text(
            //           "Total em caixa",
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         Text(
            //           value,
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 26,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
