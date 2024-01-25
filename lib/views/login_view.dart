import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:chat_app/views/forgot_password_view.dart';
import 'package:chat_app/widgets/constant_sized_boxs.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = "", password = "", name = "", pic = "", username = "", id = "";
  final TextEditingController userMailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      QuerySnapshot querySnapshot =
          await DatabaseMethods().getUserByEmail(email);

      name = "${querySnapshot.docs[0]["Name"]}";
      username = "${querySnapshot.docs[0]["Username"]}";
      pic = "${querySnapshot.docs[0]["Photo"]}";
      id = querySnapshot.docs[0].id;

      await SharedPreferenceHelper().saveUserDisplayName(name);
      await SharedPreferenceHelper().saveUserName(username);
      await SharedPreferenceHelper().saveUserId(id);
      await SharedPreferenceHelper().saveUserPic(pic);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeView()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(ProjectStrings.errorUser)));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(ProjectStrings.wrongPassword)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            decorativeLoginContainer(context),
            Padding(
              padding: const ProjectPaddings.onlyTop() * 7,
              child: loginMenu(context),
            )
          ],
        ),
      ),
    );
  }

  Column loginMenu(BuildContext context) {
    return Column(
              children: [
                const Center(
                    child: Text(
                  ProjectStrings.welcomeText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                )),
                const Center(
                    child: Text(
                  ProjectStrings.accountLogin,
                  style: TextStyle(
                      color: ProjectColors.customWhite,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                )),
                ConstantSizedBoxs.normalHeightSizedBox(),
                Container(
                  margin: const ProjectPaddings.symmetricMedium(),
                  child: Material(
                    elevation: ProjectElevations.normal.value,
                    borderRadius: ProjectBorders.circularSmall(),
                    child: loginMenuContainer(context),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                notAccountWidget(context)
              ],
            );
  }

  Container decorativeLoginContainer(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [ProjectColors.secondary, ProjectColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width, 105))));
  }

  Container loginMenuContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
      height: MediaQuery.of(context).size.height / 1.6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ProjectColors.white,
          borderRadius: ProjectBorders.circularSmall()),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              ProjectStrings.emailName,
              style: TextStyle(
                  color: ProjectColors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
            ConstantSizedBoxs.lowHeightSizedBox(),
            emailWidget(),
            ConstantSizedBoxs.normalHeightSizedBox(),
            const Text(
              ProjectStrings.passwordRegister,
              style: TextStyle(
                  color: ProjectColors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
            ConstantSizedBoxs.lowHeightSizedBox(),
            passwordWidget(),
            ConstantSizedBoxs.lowHeightSizedBox(),
            dontRememberPasswordWidget(context),
            const SizedBox(
              height: 50.0,
            ),
            customLoginButton(),
          ],
        ),
      ),
    );
  }

  Container emailWidget() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: ProjectColors.lowBlack),
          borderRadius: ProjectBorders.circularSmall()),
      child: TextFormField(
        controller: userMailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ProjectStrings.errorEmail;
          }
          return null;
        },
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon:
                Icon(Icons.mail_outline, color: ProjectColors.iconPurple)),
      ),
    );
  }

  Container passwordWidget() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: ProjectColors.lowBlack),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: userPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ProjectStrings.errorPassword;
          }
          return null;
        },
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.password, color: ProjectColors.iconPurple)),
        obscureText: true,
      ),
    );
  }

  GestureDetector dontRememberPasswordWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ForgotPasswordView()));
      },
      child: Container(
        alignment: Alignment.bottomRight,
        child: const Text(
          ProjectStrings.dontRememberPassword,
          style: TextStyle(
              color: ProjectColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  GestureDetector customLoginButton() {
    return GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          setState(() {
            email = userMailController.text;
            password = userPasswordController.text;
          });
        }
        userLogin();
      },
      child: Center(
        child: SizedBox(
          width: 150,
          child: Material(
            elevation: 5.0,
            borderRadius: ProjectBorders.circularSmall(),
            child: Container(
              padding: const ProjectPaddings.allNormal(),
              decoration: BoxDecoration(
                color: ProjectColors.primary,
                borderRadius: ProjectBorders.circularSmall(),
              ),
              child: const Center(
                  child: Text(
                ProjectStrings.loginTitle,
                style: TextStyle(
                    color: ProjectColors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
      ),
    );
  }

  Row notAccountWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          ProjectStrings.notAccount,
          style: TextStyle(color: ProjectColors.black, fontSize: 16.0),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterView()));
          },
          child: const Text(
            ProjectStrings.nowAccount,
            style: TextStyle(
                color: ProjectColors.customPurple,
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
