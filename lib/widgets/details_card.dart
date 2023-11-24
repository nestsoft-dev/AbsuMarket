// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsCard extends StatelessWidget {
  final String title;
  final String des;
  const DetailsCard({
    Key? key,
    required this.title,
    required this.des,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 65,
      padding: const EdgeInsets.all(8),
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 228, 228, 228)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                GoogleFonts.aBeeZee(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            des,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
