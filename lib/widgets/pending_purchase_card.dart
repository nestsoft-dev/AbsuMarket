import 'package:absumarket/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';

import '../functions/functions.dart';

class PendingCard extends StatelessWidget {
  const PendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 110,
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color.fromARGB(157, 46, 77, 250)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/product.png',
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nike 452',
                    style:
                        GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
                  ),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Approve',
                        style: GoogleFonts.aBeeZee(color: deepBlue),
                      )),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'N750.00',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 238, 238, 238),
                              borderRadius: BorderRadius.circular(8)),
                          child: GestureDetector(
                              onTap: () => showProductDetails(context),
                              child: Icon(Iconsax.eye))),

                      //Call seller
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8)),
                          child: GestureDetector(
                              onTap: () => showProductDetails(context),
                              child: const Icon(Iconsax.call,
                                  color: Colors.white))),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        //Text('⌚')
        Positioned(
          right: 0,
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 196, 196, 196),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(Iconsax.timer)),
        )
      ],
    );
  }
}
