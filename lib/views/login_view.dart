import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/viewmodels/login_viewmodel.dart';
import 'package:chat_app/views/forgot_password_view.dart';
import 'package:chat_app/widgets/sizedboxs/constant_sized_boxs.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends LoginViewModel {
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
        Center(
            child: Text(ProjectStrings.welcomeText,
                style: context.projectTheme().titleLarge?.copyWith(
                    color: ProjectColors.white, fontWeight: FontWeight.w600))),
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
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ProjectStrings.emailName,
              style: context.projectTheme().titleMedium?.copyWith(
                    color: ProjectColors.iconPurple,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            ConstantSizedBoxs.lowHeightSizedBox(),
            emailWidget(),
            ConstantSizedBoxs.normalHeightSizedBox(),
            Text(
              ProjectStrings.passwordRegister,
              style: context.projectTheme().titleMedium?.copyWith(
                    color: ProjectColors.iconPurple,
                    fontWeight: FontWeight.w500,
                  ),
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
        if (formkey.currentState!.validate()) {
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
