import 'package:chat_app/constants/project_colors.dart';
import 'package:flutter/material.dart';
class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordTextFormField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
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
              ?  eyeIcon()
              :  eyeOutlinedIcon(),
          onTap: () {
      setState(() {
              isVisible.value = !isVisible.value;
           });
          },
        ),
      ),
    );
  }

  Icon eyeOutlinedIcon() => const Icon(Icons.remove_red_eye, color: ProjectColors.iconPurple,);

  Icon eyeIcon() => const Icon(Icons.remove_red_eye_outlined,color: ProjectColors.iconPurple,);

  
}


class RegisterInputDecoration extends InputDecoration {
  const RegisterInputDecoration(
      InputBorder border, Widget prefixIcon, Widget suffixIcon)
      : super(border: border, prefixIcon: prefixIcon, suffixIcon: suffixIcon);
}
