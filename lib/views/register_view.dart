import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/widgets/sizedboxs/constant_sized_boxs.dart';
import 'package:chat_app/widgets/textfields/password_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String email = "", password = "", name = "", confirmPassword = "";
  //default profile photo
  final String defaultPhotoUrl =
      "https://as1.ftcdn.net/v2/jpg/05/90/59/88/1000_F_590598870_TOcGd4cUZzPoEMlxSc7XYwcupHOE0vLM.jpg";

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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

  final _formkey = GlobalKey<FormState>();

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
            key: _formkey,
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
        if (_formkey.currentState!.validate()) {
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
