import 'package:chat_app/views/onboarding_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
 @override
 void initState() {
   super.initState();
   Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingView()), // Ana ekran widget'ı
      );
    });
 }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Image.asset("assets/splash.gif",fit: BoxFit.cover,),
    );
  }
}