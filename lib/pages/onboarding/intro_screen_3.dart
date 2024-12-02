import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 93,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Logo
                Image.asset(
                  'assets/images/mandisetu_logo.png',
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: 240,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/intro/3.json',
              height: 300,
            ),
          ),
          const Positioned(
            top: 550,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Access Fresh Produce Directly from Farmers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Get quality items delivered straight to you.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Browse a wide range of fresh produce from local farmers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
