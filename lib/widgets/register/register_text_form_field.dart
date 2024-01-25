import 'package:flutter/material.dart';
class RegisterTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const RegisterTextFormField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<RegisterTextFormField> createState() => _RegisterTextFormFieldState();
}

class _RegisterTextFormFieldState extends State<RegisterTextFormField> {
  final ValueNotifier<bool> isVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !isVisible.value,
      validator: widget.validator,
      decoration: RegisterInputDecoration(
        InputBorder.none,
        const Icon(Icons.password),
        GestureDetector(
          child: isVisible.value
              ? const Icon(Icons.lock_open_sharp)
              : const Icon(Icons.lock_outline),
          onTap: () {

           setState(() {
              isVisible.value = !isVisible.value;
           });
          },
        ),
      ),
    );
  }
}


class RegisterInputDecoration extends InputDecoration {
  const RegisterInputDecoration(
      InputBorder border, Widget prefixIcon, Widget suffixIcon)
      : super(border: border, prefixIcon: prefixIcon, suffixIcon: suffixIcon);
}
