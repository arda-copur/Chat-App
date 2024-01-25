import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/utils/image_utils.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/widgets/sizedboxs/constant_sized_boxs.dart';
import 'package:flutter/material.dart';

class IntroPageFirst extends StatelessWidget {
  const IntroPageFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.infoBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ProjectStrings.firstDescription,
                style: context.projectTheme().headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800, color: ProjectColors.lowWhite)),
          ),
          ConstantSizedBoxs.largeHeightSizedBox(),
          Center(
            child: Image.asset(
              ImageItems.infoguy1.imagePath,
              width: MediaQuery.of(context).size.width * 0.65,
            ),
          )
        ],
      ),
    );
  }
}
