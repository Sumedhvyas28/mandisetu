import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroSmallPage1 extends StatefulWidget {
  const IntroSmallPage1({super.key});

  @override
  State<IntroSmallPage1> createState() => _IntroSmallPage1State();
}

class _IntroSmallPage1State extends State<IntroSmallPage1> {
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
            top: 140,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/intro/1.json',
              height: 300,
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
                  'Farm-to-Market Process',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Organize your farming sales in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Stay on top of your stock, from farm to market.',
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
