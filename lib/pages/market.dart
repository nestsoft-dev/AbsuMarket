import 'package:absumarket/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/colors.dart';
import '../constants/colors.dart';
import '../widgets/carousel.dart';
import '../widgets/categories_car.dart';
import '../widgets/recent_card.dart';

class Market extends StatefulWidget {
  Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  CarouselController? carouselController;

  int caroInt = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          //carousel
          Carousel(size: size,),

          //
          SizedBox(
            height: size.height * 0.03,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Most Recent',
                  style: GoogleFonts.aBeeZee(
                      //  color: Colors.white,
                      //  fontWeight: FontWeight.bold,
                      fontSize: 16))),
          SizedBox(
            height: size.height * 0.01,
          ),
          SizedBox(
            height: 235,
            width: size.width,
            child: ListView.builder(
                itemCount: 8,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: RecentsCard(),
                    )),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Categories',
                  style: GoogleFonts.aBeeZee(
                      //  color: Colors.white,
                      //  fontWeight: FontWeight.bold,
                      fontSize: 16))),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            height: size.height * 0.15,
            width: size.width,
            padding: const EdgeInsets.all(3),
            child: Center(
              child: GridView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 100,
                      crossAxisSpacing: 15),
                  itemBuilder: (_, index) => const CategoriesCard()),
            ),
          )
        ],
      ),
    );
  }
}
