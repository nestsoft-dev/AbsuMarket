// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height * 0.25,
      child: Column(
        children: [
          CarouselSlider(
              carouselController: carouselController,
              items: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/product1.png',
                      width: widget.size.width,
                      height: widget.size.height * 0.10,
                      fit: BoxFit.cover,
                    )),
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/product2.png',
                      width: widget.size.width,
                      height: widget.size.height * 0.15,
                      fit: BoxFit.cover,
                    )),
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/product3.png',
                      width: widget.size.width,
                      height: widget.size.height * 0.15,
                      fit: BoxFit.cover,
                    )),
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/product4.png',
                      width: widget.size.width,
                      height: widget.size.height * 0.15,
                      fit: BoxFit.cover,
                    )),
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/product5.png',
                      width: widget.size.width,
                      height: widget.size.height * 0.15,
                      fit: BoxFit.cover,
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
          const SizedBox(
            height: 5,
          ),
          Center(
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
          )
        ],
      ),
    );
  }
}
