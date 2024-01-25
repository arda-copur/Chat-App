import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/utils/image_utils.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/widgets/constant_sized_boxs.dart';
import 'package:flutter/material.dart';

class IntroPageSecond extends StatelessWidget {
  const IntroPageSecond({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: ProjectColors.infoBackground,
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Text(ProjectStrings.secondDescription,style: 
        context.projectTheme().headlineSmall?.copyWith(fontWeight: FontWeight.w800,color: ProjectColors.lowWhite)
        ),
        
        ConstantSizedBoxs.largeHeightSizedBox(),
        Center(
          child: 
          Image.asset(ImageItems.infoguy2.imagePath,
          width: MediaQuery.of(context).size.width * 0.6,
          ),
        )
      
       ],
      ),
    );
  }
}