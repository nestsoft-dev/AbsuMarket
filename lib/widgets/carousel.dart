// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../functions/functions.dart';
import '../screens/shop.dart';

class Carousel extends StatefulWidget {
  final Size size;

  const Carousel({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  CarouselController? carouselController;

  int caroInt = 0;
  //SellerShop
  List<String> products = [
    'assets/product1.png',
    'assets/product2.png',
    'assets/product3.png',
    'assets/product4.png',
    'assets/product5.png',
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: caroSlider(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.length == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: widget.size.height * 0.25,
                    child: Column(
                      children: [
                        CarouselSlider(
                            carouselController: carouselController,
                            items: snapshot.data!
                                .map(
                                  (item) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SellerShop(
                                                    sellerId: item.storeId,
                                                  )));
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          item.imageUrl,
                                          width: widget.size.width,
                                          height: widget.size.height * 0.10,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
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
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0; i < snapshot.data!.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: 5,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: caroInt == i
                                            ? lightyellow
                                            : Color.fromARGB(
                                                255, 175, 175, 175)),
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error Displaying Ads'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: deepBlue,
              ),
            );
          }
        });
  }
}
