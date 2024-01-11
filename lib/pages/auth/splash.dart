import 'package:absumarket/constants/colors.dart';
import 'package:flutter/material.dart';

import 'authgate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false);
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: deepBlue,
        ),
      ),
    );
  }
}
