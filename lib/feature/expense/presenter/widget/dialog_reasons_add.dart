import 'package:account_control/feature/expense/presenter/widget/dialog_simple_register.dart';
import 'package:flutter/material.dart';

class DialogReasonsAdd extends StatelessWidget {
  final Function saveController;
  final String nameForm;
  final String title;
  final String message;
  final String messageHighlighted;

  const DialogReasonsAdd({
    Key? key,
    required this.saveController,
    required this.nameForm,
    required this.title,
    required this.message,
    required this.messageHighlighted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogSimpleRegister(
              message: message,
              messageHighlighted: messageHighlighted,
              ontap: (val) {
                saveController(val);
              },
              nameForm: nameForm,
              title: title,
            );
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
