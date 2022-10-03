import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DentrodobolsoTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final IconButton? suffixIcon;
  final ValueNotifier<bool> _obscureTextVN;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? textInputFormatter;

  DentrodobolsoTextFormField({
    Key? key,
    required this.label,
    this.textInputType,
    this.controller,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputFormatter,
  })  : _obscureTextVN = ValueNotifier<bool>(obscureText),
        assert(obscureText == true ? suffixIcon == null : true,
            'obscureText não pode ser adicionado junto com o suffixicon'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          inputFormatters: textInputFormatter,
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          obscureText: obscureTextValue,
          decoration: InputDecoration(
            isDense: true,
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 15,
              color: context.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              gapPadding: 0,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              gapPadding: 0,
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            suffixIcon: obscureText
                ? IconButton(
                    onPressed: () {
                      _obscureTextVN.value = !obscureTextValue;
                    },
                    icon: Icon(
                      obscureTextValue ? Icons.lock : Icons.lock_open,
                      color: context.primaryColor,
                    ),
                  )
                : suffixIcon,
          ),
        );
      },
    );
  }
}
