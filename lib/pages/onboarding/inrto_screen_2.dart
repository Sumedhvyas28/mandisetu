import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InrtoScreen2 extends StatelessWidget {
  const InrtoScreen2({super.key});

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
              'assets/intro/2.json',
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
                  'Efficient Stock Sourcing and Distribution',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Easily find the best produce from farmers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Streamline your stock purchasing and distribution process.',
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
