import 'package:chat_app/utils/image_utils.dart';
import 'package:chat_app/widgets/constant_sized_boxs.dart';
import 'package:flutter/material.dart';

class IntroPageThird extends StatelessWidget {
  const IntroPageThird({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Text("Artık mesajlaşmak çok kolay...",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w800,color: Colors.black45,fontSize: 24
        ),
        ),
        ConstantSizedBoxs.largeHeightSizedBox(),
        Center(
          child: 
          Image.asset(ImageItems.infoguy3.imagePath,
          width: MediaQuery.of(context).size.width * 0.6,
          ),
        )
      
       ],
      ),
    );
  }
}