import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarButton extends StatelessWidget {
  final DateTime? selectdDate;
  final double width;
  final String buttonLabel;
  final dateFormat = DateFormat('dd/MM/y');
  final void Function(DateTime) onChanged;

  CalendarButton({
    Key? key,
    this.selectdDate,
    required this.onChanged,
    required this.width,
    required this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate.add(
          const Duration(days: 10 * 365),
        );
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
        ).then((value) {
          if (value != null) {
            onChanged(value);
          }
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: width,
        height: 64,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            // Observer(builder: (_) {
            //   return
            Expanded(
              child: Text(
                selectdDate != null
                    ? dateFormat.format(selectdDate!)
                    : buttonLabel,
                overflow: TextOverflow.ellipsis,
              ),
              // );
              // }
            ),
          ],
        ),
      ),
    );
  }
}
