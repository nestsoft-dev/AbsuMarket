// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'package:absumarket/constants/colors.dart';

import '../functions/functions.dart';
import '../models/pendind_model.dart';

class PendingCard extends StatelessWidget {
  final int index;
  final PendingModel pendingModel;
  PendingCard({
    Key? key,
    required this.index,
    required this.pendingModel,
  }) : super(key: key);

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                child: Image.network(
                  pendingModel.imageUrl,
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: width * 0.30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pendingModel.productname,
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => approveProduct(
                          context,
                          pendingModel.productname,
                          pendingModel.price.toInt(),
                          textEditingController,pendingModel),
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Approve',
                            style: GoogleFonts.aBeeZee(color: deepBlue),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'N${pendingModel.price}',
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
                              onTap: () =>
                                  showProductDetails(context, pendingModel),
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
                              onTap: () =>
                                  showProductDetails(context, pendingModel),
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
