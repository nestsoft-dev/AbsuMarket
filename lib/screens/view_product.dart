import 'package:absumarket/models/productmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import 'buy.dart';
import 'chat_screen.dart';
import 'shop.dart';

class ViewProducts extends StatefulWidget {
  final ProductModel product;

  ViewProducts({super.key, required this.product});

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  CarouselController? carouselController;

  int caroInt = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 240, 240, 240)),
                    height: size.height * 0.45,
                    width: size.width,
                    child: CarouselSlider(
                        carouselController: carouselController,
                        items: widget.product.images.length == 0
                            ? [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/product.png',
                                      width: size.width,
                                      height: size.height,
                                      fit: BoxFit.contain,
                                    )),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/product.png',
                                      width: size.width,
                                      height: size.height,
                                      fit: BoxFit.contain,
                                    )),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/product.png',
                                      width: size.width,
                                      height: size.height,
                                      fit: BoxFit.contain,
                                    )),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/product.png',
                                      width: size.width,
                                      height: size.height,
                                      fit: BoxFit.contain,
                                    )),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/product.png',
                                      width: size.width,
                                      height: size.height,
                                      fit: BoxFit.contain,
                                    )),
                              ]
                            : widget.product.images
                                .map(
                                  (image) => ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        image.toString(),
                                        width: size.width,
                                        height: size.height,
                                        fit: BoxFit.cover,
                                      )),
                                )
                                .toList(),
                        options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlay: true,
                            onPageChanged: (index, controll) {
                              setState(() {
                                caroInt = index;
                              });
                            })),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 50,
                    right: 50,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < widget.product.images.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                height: 5,
                                width: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: caroInt == i
                                        ? lightyellow
                                        : Color.fromARGB(255, 175, 175, 175)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.product.productName,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'N${widget.product.price}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                            color: deepBlue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellerShop(
                                        sellerId: widget.product.storeOwnerUID,
                                      )));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.shop,
                              color: deepBlue,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.product.storeName,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.mulish(
                                  color: deepyellow,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'About Product',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.product.productDes,
                    textAlign: TextAlign.left,
                    maxLines: 10,
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),

                  // const Spacer(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuyItem(
                                      product: widget.product,
                                    )));
                      },
                      child: Container(
                        height: 50,
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                            color: deepBlue,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Iconsax.buy_crypto,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Buy',
                                style: GoogleFonts.aBeeZee(color: Colors.white),
                              )
                            ]),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => const ChatScreen()));
                  //       },
                  //       child: Container(
                  //         height: 50,
                  //         width: 120,
                  //         decoration: BoxDecoration(
                  //             color: Colors.blue,
                  //             borderRadius: BorderRadius.circular(12)),
                  //         child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Icon(
                  //                 Icons.message,
                  //                 color: Colors.white,
                  //               ),
                  //               const SizedBox(
                  //                 width: 5,
                  //               ),
                  //               Text(
                  //                 'Chat',
                  //                 style:
                  //                     GoogleFonts.aBeeZee(color: Colors.white),
                  //               )
                  //             ]),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => const BuyItem()));
                  //       },
                  //       child: Container(
                  //         height: 50,
                  //         width: 120,
                  //         decoration: BoxDecoration(
                  //             color: deepBlue,
                  //             borderRadius: BorderRadius.circular(12)),
                  //         child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Icon(
                  //                 Iconsax.buy_crypto,
                  //                 color: Colors.white,
                  //               ),
                  //               const SizedBox(
                  //                 width: 5,
                  //               ),
                  //               Text(
                  //                 'Buy',
                  //                 style:
                  //                     GoogleFonts.aBeeZee(color: Colors.white),
                  //               )
                  //             ]),
                  //       ),
                  //     ),
                  //     Container(
                  //       height: 50,
                  //       width: 120,
                  //       decoration: BoxDecoration(
                  //           color: deepyellow,
                  //           borderRadius: BorderRadius.circular(12)),
                  //       child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             const Icon(
                  //               Iconsax.call,
                  //               color: Colors.white,
                  //             ),
                  //             const SizedBox(
                  //               width: 5,
                  //             ),
                  //             Text(
                  //               'Call',
                  //               style: GoogleFonts.aBeeZee(color: Colors.white),
                  //             )
                  //           ]),
                  //     )
                  //   ],
                  // )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
