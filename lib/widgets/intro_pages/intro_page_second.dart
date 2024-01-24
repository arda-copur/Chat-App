import 'package:chat_app/utils/image_utils.dart';
import 'package:chat_app/widgets/constant_sized_boxs.dart';
import 'package:flutter/material.dart';

class IntroPageSecond extends StatelessWidget {
  const IntroPageSecond({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Text("Artık mesajlaşmak çok kolay!",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w800,color: Colors.black45,
        ),
        ),
           Text("Yükle ve hemen arkadaşlarınla sohbet etmeye başla...",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w800,color: Colors.grey[350],
        ),
        
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