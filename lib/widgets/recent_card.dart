import 'package:absumarket/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/colors.dart';

class RecentsCard extends StatelessWidget {
  const RecentsCard({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 160,
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
                child: Image.network(
                  model.images[0].toString(),
                  height: 130,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name
                    Text(
                      model.productName,
                      maxLines: 1,
                      style: GoogleFonts.aBeeZee(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    //Store Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Iconsax.shop, size: 15),
                        Text(
                          model.storeName,
                          style: GoogleFonts.aboreto(
                              color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    //price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        model.discountprice == 0
                            ? Text(
                                '₦${model.price}',
                                style: TextStyle(color: deepBlue, fontSize: 16),
                              )
                            : Text(
                                '₦${model.discountprice}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
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
                          model.location,
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
          model.discountprice == 0
              ? SizedBox.shrink()
              : Positioned(
                  top: 10,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(216, 255, 235, 59)),
                    child: Text(
                      '-${model.discountprice / model.price * 100}%',
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
