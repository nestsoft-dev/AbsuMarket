import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          // image: DecorationImage(image: AssetImage('assets/product.png')),
          color: const Color.fromARGB(143, 0, 0, 0),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
          child: Text('Shoes',
              style: GoogleFonts.aBeeZee(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16))),
    );
  }
}
