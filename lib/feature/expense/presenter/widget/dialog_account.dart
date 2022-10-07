import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:account_control/core/ui/widgets/text_icon_button.dart';
import 'package:flutter/material.dart';

class DialogAccount extends StatelessWidget {
  final String message;
  final String messageHighlighted;
  final String title;
  final Function onTapBanco;
  final Function onTapConta;

  const DialogAccount({
    Key? key,
    required this.message,
    required this.title,
    required this.onTapBanco,
    required this.onTapConta,
    required this.messageHighlighted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: message),
                  TextSpan(
                    text: " $messageHighlighted.",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 12),
      actions: [
        TextIconButton(
          icon: Icons.account_balance_outlined,
          title: 'Banco',
          color: context.darkBlue,
          width: 110,
          onTap: () {
            Navigator.pop(context);
            onTapBanco();
          },
        ),
        const SizedBox(
          width: 8,
        ),
        TextIconButton(
          icon: Icons.payment,
          title: 'Conta',
          color: context.darkBlue,
          width: 110,
          onTap: () {
            Navigator.pop(context);
            onTapConta();
          },
        ),
      ],
      buttonPadding: const EdgeInsets.only(bottom: 46),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        title,
        style: TextStyle(
          color: context.darkBlue,
        ),
      ),
    );
  }
}
