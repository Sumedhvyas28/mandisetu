import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroSmallPage2 extends StatefulWidget {
  const IntroSmallPage2({super.key});

  @override
  State<IntroSmallPage2> createState() => _IntroSmallPage2State();
}

class _IntroSmallPage2State extends State<IntroSmallPage2> {
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
              'assets/intro/2.json',
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
                  'Efficient Stock Sourcing and Distribution',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Easily find the best produce from farmers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Streamline your stock purchasing and distribution process.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
