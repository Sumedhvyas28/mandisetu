import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

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
            top: 140,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/intro/1.json',
              height: 420,
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
                  'Streamlined Farm-to-Market Process',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Organize your farming sales in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Stay on top of your stock, from farm to market.',
                  style: TextStyle(fontSize: 16),
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
