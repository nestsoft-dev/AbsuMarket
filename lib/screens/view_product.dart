import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ViewProducts extends StatefulWidget {
  ViewProducts({super.key});

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
        child: Column(children: [
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
                  child: CarouselSlider(
                      carouselController: carouselController,
                      items: [
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
                      ],
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
                        for (int i = 0; i < 5; i++)
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
        ]),
      ),
    );
  }
}
