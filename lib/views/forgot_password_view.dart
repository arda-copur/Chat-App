import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/viewmodels/forgot_password_viewmodel.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/sizedboxs/constant_sized_boxs.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ForgotPasswordViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            backgroundContainer(context),
            Padding(
              padding: const ProjectPaddings.allNormal() * 7,
              child: Column(
                children: [
                  Center(
                      child: Text(
                    ProjectStrings.dontRememberPassword,
                    style: context.projectTheme().headlineSmall?.copyWith(
                        color: ProjectColors.white,
                        fontWeight: FontWeight.w600),
                  )),
                  const Center(
                      child: Text(
                    ProjectStrings.oldEmail,
                    style: TextStyle(
                        color: ProjectColors.iconPurple,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  )),
                  ConstantSizedBoxs.normalHeightSizedBox(),
                  decorativeContainer(context),
                  const SizedBox(
                    height: 40.0,
                  ),
                  GoRegisterView(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container backgroundContainer(BuildContext context) {
    return Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    ProjectColors.primary,
                    ProjectColors.customPurple
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 105))));
  }

  Container decorativeContainer(BuildContext context) {
    return Container(
                  margin: const ProjectPaddings.symmetricMedium(),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 20.0),
                      height: MediaQuery.of(context).size.height / 2.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: ProjectColors.white,
                          borderRadius: ProjectBorders.circularSmall()),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ProjectStrings.emailName,
                                style: context
                                    .projectTheme()
                                    .titleMedium
                                    ?.copyWith(
                                        color: ProjectColors.iconPurple,
                                        fontWeight: FontWeight.w500)),
                           ConstantSizedBoxs.lowHeightSizedBox(),
                            sendMailTextField(),
                            const SizedBox(
                              height: 50.0,
                            ),
                            sendMailContainer(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
  }

  Container sendMailTextField() {
    return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0,
                                      color: ProjectColors.lowBlack),
                                  borderRadius:
                                      ProjectBorders.circularSmall()),
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
                                    prefixIcon: Icon(Icons.mail_outline,
                                        color: ProjectColors.iconPurple)),
                              ),
                            );
  }

  GestureDetector sendMailContainer(BuildContext context) {
    return GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    email = userMailController.text;
                                  });
                                  resetPassword();
                                }
                              },
                              child: Center(
                                child: SizedBox(
                                  width: 150,
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius:
                                        ProjectBorders.circularSmall(),
                                    child: Container(
                                      padding:
                                          const ProjectPaddings.allNormal(),
                                      decoration: BoxDecoration(
                                        color: ProjectColors.customPurple,
                                        borderRadius:
                                            ProjectBorders.circularSmall(),
                                      ),
                                      child: Center(
                                          child: Text(ProjectStrings.sendText,
                                              style: context
                                                  .projectTheme()
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: ProjectColors
                                                          .white))),
                                    ),
                                  ),
                                ),
                              ),
                            );
  }

  Row GoRegisterView(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ProjectStrings.notAccount,
                        style: context
                            .projectTheme()
                            .titleMedium
                            ?.copyWith(color: ProjectColors.black)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterView()));
                      },
                      child: Text(
                        ProjectStrings.nowAccount,
                        style: context.projectTheme().titleMedium?.copyWith(
                            color: ProjectColors.customPurple,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                );
  }
}
