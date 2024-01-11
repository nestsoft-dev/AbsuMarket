// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:absumarket/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OnBoardingCard extends StatelessWidget {
  final Color color1;
  final Color color12;
  final String lottie;
  final String title;
  final String des;
  const OnBoardingCard({
    Key? key,
    required this.color1,
    required this.color12,
    required this.lottie,
    required this.title,
    required this.des,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [color1, color12]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            //lottie
            Lottie.asset('assets/$lottie'),

            SizedBox(
              height: size.height * 0.03,
            ),
            //title
            Text(
              title,
              style: GoogleFonts.aBeeZee(color: deepBlue, fontSize: 25),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),

            //des
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                des,
                textAlign: TextAlign.center,
                style: GoogleFonts.podkova(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
