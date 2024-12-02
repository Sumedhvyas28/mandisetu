import 'package:flutter/material.dart';
import 'package:mandisetu/pages/onboarding/inrto_screen_2.dart';
import 'package:mandisetu/pages/onboarding/intro_screen_1.dart';
import 'package:mandisetu/pages/onboarding/intro_screen_3.dart';
import 'package:mandisetu/pages/onboarding/sintro_screen1.dart';
import 'package:mandisetu/pages/onboarding/sintro_screen2.dart';
import 'package:mandisetu/pages/onboarding/sintro_screen3.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    List<Widget> introPages = [
      const IntroPage1(),
      const InrtoScreen2(),
      const IntroScreen3(),
    ];
    if (screenHeight <= 800) {
      introPages = const [
        IntroSmallPage1(),
        IntroSmallPage2(),
        IntroSmallPage3(),
      ];
    } else {
      introPages = const [
        IntroPage1(),
        InrtoScreen2(),
        IntroScreen3(),
      ];
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
                onLastPage = (index == 2);
              });
            },
            children: introPages,
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                // count: introPages.length,
                count: 3,
                effect: const ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 5,
                  spacing: 10,
                  expansionFactor: 7,
                  activeDotColor: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentPageIndex == 0) {
                      _controller.jumpToPage(2);
                    } else {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    }
                  },
                  child: Text(
                    currentPageIndex == 0 ? 'SKIP' : 'BACK',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (onLastPage) {
                      Navigator.pushReplacementNamed(
                          context, NamedRoutes.login);
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    }
                  },
                  child: Text(
                    onLastPage ? 'GET STARTED' : 'NEXT',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
