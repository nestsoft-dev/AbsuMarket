// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesCard extends StatelessWidget {
  final int index;
  CategoriesCard({
    Key? key,
    required this.index,
  }) : super(key: key);
  final List<String> categories = [
    'Electronics',
    'Food',
    'Shoes',
    'Cloths',
    'Cosmetics',
    'Services',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          image: const DecorationImage(image: AssetImage('assets/product.png')),
          color: Colors.blue,
          // color: const Color.fromARGB(143, 0, 0, 0),
          borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(221, 12, 12, 12),
                borderRadius: BorderRadius.circular(12)),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(
                  child: Text(categories[index],
                      style: GoogleFonts.aBeeZee(
                          color: const Color.fromARGB(255, 219, 218, 218),
                          fontWeight: FontWeight.bold,
                          fontSize: 16))))
        ],
      ),
    );
  }
}
