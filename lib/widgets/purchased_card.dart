// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../functions/functions.dart';
import '../models/purchased_model.dart';

class PurchasedCard extends StatelessWidget {
  const PurchasedCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final PurchasedModel model;

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
              color: Color.fromARGB(164, 0, 172, 77)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  model.imageUrl,
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
                    model.storeName,
                    style:
                        GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => viewPastPurchase(context, model),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'View Details',
                          style: GoogleFonts.aBeeZee(color: deepBlue),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'N${model.amount}',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  ),
                  Spacer(),
                  // Container(
                  //     padding: const EdgeInsets.all(8),
                  //     decoration: BoxDecoration(
                  //         color: Color.fromARGB(255, 238, 238, 238),
                  //         borderRadius: BorderRadius.circular(8)),
                  //     child: GestureDetector(
                  //         onTap: () => showProductDetails(context),
                  //         child: Icon(Iconsax.eye))),
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
                  color: lightyellow, borderRadius: BorderRadius.circular(8)),
              child: const Icon(
                Iconsax.verify,
                color: deepBlue,
              )),
        )
      ],
    );
  }
}
