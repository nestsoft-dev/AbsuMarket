import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../widgets/button.dart';

void showProductDetails(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (context) => Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
//1st row
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                          style: GoogleFonts.aBeeZee(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Iconsax.shop, size: 15),
                            Text(
                              'Amax Stiches',
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
                            Text(
                              '₦ 2500.00',
                              style: GoogleFonts.aboreto(
                                  color: deepBlue, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(216, 255, 235, 59)),
                              child: const Text(
                                'Pending',
                              ),
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
                            const Icon(
                              Iconsax.location,
                              color: deepyellow,
                              size: 15,
                            ),
                            Text(
                              'Aba',
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                      "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Fugiat commodi vel enim veniam nemo est itaque excepturi aliquam at quam, illo expedita quia fuga possimus. Nulla, voluptatum. Quas, in commodiItaque natus beatae numquam tempore possimus tempora totam illum officia, atque illo corrupti enim magnam ducimus vitae libero magni at Magnam, officiis porro. Voluptas tenetur nesciunt rem enim hic impedit.olorem debitis esse enim necessitatibus inventore non quia, maxime in Sed suscipit quaerat possimus ipsam iste numquam nisi culpa dolorum, corrupti voluptatem velit impedit neque tempore quibusdam voluptate molestias vitae")),
              const Button(
                  backroundColor: deepBlue,
                  borderColor: deepyellow,
                  text: 'Complain')
            ],
          ),
        ));

void viewPastPurchase(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (_) => Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
//1st row
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                          style: GoogleFonts.aBeeZee(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Iconsax.shop, size: 15),
                            Text(
                              'Amax Stiches',
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
                            Text(
                              '₦ 2500.00',
                              style: GoogleFonts.aboreto(
                                  color: deepBlue, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(216, 255, 235, 59)),
                              child: const Text(
                                'Purchased',
                              ),
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
                            const Icon(
                              Iconsax.location,
                              color: deepyellow,
                              size: 15,
                            ),
                            Text(
                              'Aba',
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //purchased date nn time
                        Row(
                          children: [
                            Text(
                              'Date & Time:',
                              style: GoogleFonts.aboreto(fontSize: 18),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '17/11/2023 by 17:35pm',
                              style: GoogleFonts.poppins(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Rating',
                          style: GoogleFonts.aboreto(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        //rating
                        Center(
                          child: Row(
                            children: [
                              for (int i = 0; i < 5; i++)
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Column(
                          children: [
                            Row(children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/product.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Lorem ipsum dolor sit, amet consectetur\n  adipisicing elit. Fugiat commodivel\nenim veniam nemo est \nitaqueexcepturi aliquam at quam,\nillo expedita quia fuga possimus.\ncommodiItaquebeataenumqu\namtempore possimus tempora totam illum\n",
                                  textAlign: TextAlign.start,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ]),
                          ],
                        )
                      ])),
              const Spacer(),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Button(
                    backroundColor: deepBlue,
                    borderColor: deepyellow,
                    text: 'Close'),
              )
            ],
          ),
        ));
