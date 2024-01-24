import 'package:chat_app/utils/image_utils.dart';
import 'package:chat_app/widgets/constant_sized_boxs.dart';
import 'package:flutter/material.dart';

class IntroPageFirst extends StatelessWidget {
  const IntroPageFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("İstediğin an, istediğin yerde arkadaşlarınla mesajlaşmak mı istiyorsun?",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w800,color: Colors.black45
          ),
          ),
        ),
        ConstantSizedBoxs.largeHeightSizedBox(),
        Center(
          child: 
          Image.asset(ImageItems.infoguy1.imagePath,
          width: MediaQuery.of(context).size.width * 0.6,
          ),
        )
      
       ],
      ),
    );
  }
}