import 'package:flutter/material.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:mandisetu/viewmodel/user_session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserSession _userSession = UserSession();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 4));

    final isLoggedIn = await _userSession.isLoggedIn();
    print("Is user logged in: $isLoggedIn");

    if (mounted) {
      if (isLoggedIn) {
        print("User is logged in. Navigating to bottom tab...");
        Navigator.pushReplacementNamed(context, NamedRoutes.bottomTab);
      } else {
        print("User is NOT logged in. Navigating to login page...");
        Navigator.pushReplacementNamed(context, NamedRoutes.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/mandisetu_logo.png'),
          ],
        ),
      ),
    );
  }
}
