// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserOrSeller extends StatelessWidget {
  const UserOrSeller({
    Key? key,
    required this.name,
    required this.destinaltion,
  }) : super(key: key);
  final String name;
  final Widget destinaltion;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.3,
      width: width * 0.75,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: deepBlue.withOpacity(0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(fontSize: 20),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => destinaltion),
                );
              },
              child: const Button(
                  backroundColor: deepBlue,
                  borderColor: Colors.white,
                  text: 'Login'))
        ],
      ),
    );
  }
}
