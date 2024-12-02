import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroSmallPage3 extends StatefulWidget {
  const IntroSmallPage3({super.key});

  @override
  State<IntroSmallPage3> createState() => _IntroSmallPage3State();
}

class _IntroSmallPage3State extends State<IntroSmallPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Logo and title
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Logo
                Image.asset(
                  'assets/images/mandisetu_logo.png',
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          // Main image
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/intro/3.json',
              height: 270,
            ),
          ),
          // Text content
          Positioned(
              top: 420,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Access Fresh Produce Directly from Farmers',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Get quality items delivered straight to you.',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Browse a wide range of fresh produce from farmers.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
