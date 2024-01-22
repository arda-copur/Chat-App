import 'package:flutter/material.dart';

class CustomTextField extends TextField {
  const CustomTextField(TextEditingController myController, {super.key})
      : super(
            controller: myController,
            decoration: const CustomInputDecoration(
                InputBorder.none,
                Icon(
                  Icons.person_outline,
                  color: Color(0xFF7f30fe),
                )));
}

class CustomInputDecoration extends InputDecoration {
  const CustomInputDecoration(InputBorder myBorder, Icon myPrefixIcon)
      : super(border: myBorder, prefixIcon: myPrefixIcon);
}


//signin veya signupdaki textfield yerine konulacak