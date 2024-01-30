import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/views/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ForgotPasswordViewModel extends State<ForgotPasswordView> {
  String email = "";
  final formKey = GlobalKey<FormState>();

  final TextEditingController userMailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ProjectStrings.passwordReset)));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ProjectStrings.errorAccount)));
      }
    }
  }
}
