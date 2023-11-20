import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/colors.dart';

class RecentsCard extends StatelessWidget {
  const RecentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      width: 150,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 230, 230, 230),
          borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/product.png',
                    height: 130,
                    width: 150,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name
                    Text(
                      'Phone',
                      style: GoogleFonts.aBeeZee(fontSize: 18),
                    ),

                    //price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          '₦3500.00',
                          style: GoogleFonts.aboreto(
                              color: deepBlue, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    //location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Location',
                          style: GoogleFonts.poppins(),
                        ),
                        const Icon(
                          Iconsax.location,
                          color: deepyellow,
                          size: 15,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 10,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(216, 255, 235, 59)),
              child: Text(
                '-45%',
              ),
            ),
          )
        ],
      ),
    );
  }
}
