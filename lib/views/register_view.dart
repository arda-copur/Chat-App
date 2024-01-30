import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/viewmodels/register_viewmodel.dart';
import 'package:chat_app/widgets/sizedboxs/constant_sized_boxs.dart';
import 'package:chat_app/widgets/textfields/password_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends RegisterViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            decorativeContainer(context),
            Padding(
              padding: const ProjectPaddings.onlyTop() * 7,
              child: Column(
                children: [
                  Center(
                      child: Text(ProjectStrings.createAccount,
                          style: context
                              .projectTheme()
                              .headlineSmall
                              ?.copyWith(color: ProjectColors.white))),
                  Center(
                      child: Text(ProjectStrings.newAccount,
                          style: context.projectTheme().titleMedium?.copyWith(
                              color: ProjectColors.customWhite,
                              fontWeight: FontWeight.bold))),
                  ConstantSizedBoxs.normalHeightSizedBox(),
                  RegisterMenu(context),
                  ConstantSizedBoxs.normalHeightSizedBox(),
                  RegisterButton(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container decorativeContainer(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [ProjectColors.customPurple, ProjectColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width, 105))));
  }

  Container RegisterMenu(BuildContext context) {
    return Container(
      margin: const ProjectPaddings.symmetricMedium(),
      child: Material(
        elevation: ProjectElevations.normal.value,
        borderRadius: ProjectBorders.circularSmall(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: ProjectColors.white,
              borderRadius: ProjectBorders.circularSmall()),
          child: Form(
            key: formkey,
            child: TextFieldsColumn(context),
          ),
        ),
      ),
    );
  }

  Column TextFieldsColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ProjectStrings.personName,
            style: context.projectTheme().titleMedium?.copyWith(
                color: ProjectColors.iconPurple, fontWeight: FontWeight.bold)),
        ConstantSizedBoxs.lowHeightSizedBox(),
        Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: ProjectColors.lowBlack),
                borderRadius: ProjectBorders.circularSmall()),
            child: nameTextFormField()),
        ConstantSizedBoxs.normalHeightSizedBox(),
        Text(ProjectStrings.emailName,
            style: context.projectTheme().titleMedium?.copyWith(
                color: ProjectColors.iconPurple, fontWeight: FontWeight.bold)),
        ConstantSizedBoxs.lowHeightSizedBox(),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: ProjectColors.lowBlack),
              borderRadius: ProjectBorders.circularSmall()),
          child: mailTextFormField(),
        ),
        ConstantSizedBoxs.normalHeightSizedBox(),
        Text(ProjectStrings.passwordRegister,
            style: context.projectTheme().titleMedium?.copyWith(
                color: ProjectColors.iconPurple, fontWeight: FontWeight.bold)),
        ConstantSizedBoxs.lowHeightSizedBox(),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: ProjectColors.lowBlack),
              borderRadius: ProjectBorders.circularSmall()),
          child: PasswordTextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ProjectStrings.errorPassword;
              }
              return null;
            },
          ),
        ),
        ConstantSizedBoxs.normalHeightSizedBox(),
        Text(ProjectStrings.passwordControl,
            style: context.projectTheme().titleMedium?.copyWith(
                color: ProjectColors.iconPurple, fontWeight: FontWeight.bold)),
        ConstantSizedBoxs.lowHeightSizedBox(),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: ProjectColors.lowBlack),
              borderRadius: ProjectBorders.circularSmall()),
          child: PasswordTextFormField(
            controller: confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ProjectStrings.passwordControlError;
              }
              return null;
            },
          ),
        ),
        ConstantSizedBoxs.largeHeightSizedBox(),
        GoLoginViewRow(context),
      ],
    );
  }

  TextFormField nameTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.person,
            color: ProjectColors.iconPurple,
          )),
      controller: nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ProjectStrings.errorName;
        }
        return null;
      },
    );
  }

  TextFormField mailTextFormField() {
    return TextFormField(
      controller: mailController,
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
    );
  }

  Row GoLoginViewRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(ProjectStrings.alreadyAccount,
            style: context.projectTheme().titleMedium?.copyWith(
                color: ProjectColors.lowBlack, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginView()));
          },
          child: Text(ProjectStrings.loginText,
              style: context.projectTheme().titleMedium?.copyWith(
                  color: ProjectColors.iconPurple,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  GestureDetector RegisterButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (formkey.currentState!.validate()) {
          setState(() {
            email = mailController.text;
            name = nameController.text;
            password = passwordController.text;
            confirmPassword = confirmPasswordController.text;
          });
        }
        registration();
      },
      child: RegisterContainer(context),
    );
  }

  Center RegisterContainer(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: ProjectElevations.normal.value,
          borderRadius: ProjectBorders.circularSmall(),
          child: Container(
            padding: const ProjectPaddings.allNormal(),
            decoration: BoxDecoration(
                color: ProjectColors.secondary,
                borderRadius: ProjectBorders.circularSmall()),
            child: Center(
                child: Text(ProjectStrings.createText,
                    style: context.projectTheme().titleMedium?.copyWith(
                        color: ProjectColors.white,
                        fontWeight: FontWeight.bold))),
          ),
        ),
      ),
    );
  }
}
