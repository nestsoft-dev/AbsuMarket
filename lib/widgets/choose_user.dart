import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../constants/colors.dart';
import '../pages/auth/login.dart';
import '../seller/register/loginseller.dart';
import 'button.dart';

class ChooseLogin extends StatelessWidget {
  const ChooseLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset('assets/chat.json',
                repeat: false, height: height * 0.30),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              'Choose Who you want to login as today',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              'Login as a user or a seller to access the feature',
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              height: height * 0.05,
            ),
             Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Button(
                      backroundColor: deepBlue,
                      borderColor: Colors.white,
                      text: 'Buyer\'s Login'),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginSeller()));
                  },
                  child: const Button(
                      backroundColor: deepyellow,
                      borderColor: Colors.white,
                      text: 'Seller\'s Login'),
                ),
              ],
            )
          ]),
    );
  }
}
