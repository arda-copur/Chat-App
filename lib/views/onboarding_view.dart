import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/intro_pages/intro_page_first.dart';
import 'package:chat_app/widgets/intro_pages/intro_page_second.dart';
import 'package:chat_app/widgets/intro_pages/intro_page_third.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            IntroPageFirst(),
            IntroPageSecond(),
            IntroPageThird()
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text("Geç"),
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ? TextButton(
                        child: const Text("Anladım"),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterView()));
                        },
                      )
                    : TextButton(
                        child: const Text("İleri"),
                        onPressed: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      )
              ],
            ))
      ],
    ));
  }
}
