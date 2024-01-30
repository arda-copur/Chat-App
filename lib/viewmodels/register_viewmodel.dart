import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

abstract class RegisterViewModel extends State<RegisterView> {
  String email = "", password = "", name = "", confirmPassword = "";

  //default profile photo
  final String defaultPhotoUrl =
      "https://as1.ftcdn.net/v2/jpg/05/90/59/88/1000_F_590598870_TOcGd4cUZzPoEMlxSc7XYwcupHOE0vLM.jpg";

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  registration() async {
    if (password.isNotEmpty && password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        //random user id for firebase
        String id = randomAlphaNumeric(10);

        String user = mailController.text.replaceAll("@gmail.com", "");
        String updateUserName = user.replaceAll(user[0], user[0].toUpperCase());
        String firstLetter = user.substring(0, 1).toUpperCase();

        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "E-mail": mailController.text,
          //for users primary usernames
          "Username": updateUserName.toUpperCase(),
          "SearchKey": firstLetter,
          "Photo": defaultPhotoUrl,

          "id": id,
        };

        await DatabaseMethods().addUserDetails(userInfoMap, id);
        await SharedPreferenceHelper().saveUserId(id);
        await SharedPreferenceHelper().saveUserDisplayName(nameController.text);
        await SharedPreferenceHelper().saveUserEmail(mailController.text);
        await SharedPreferenceHelper().saveUserPic(defaultPhotoUrl);
        await SharedPreferenceHelper().saveUserName(
            mailController.text.replaceAll("@gmail.com", "").toUpperCase());

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(ProjectStrings.successRegister)));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(ProjectStrings.weakPassword)));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(ProjectStrings.alreadyEmail)));
        }
      }
    }
  }

  final formkey = GlobalKey<FormState>();
}
