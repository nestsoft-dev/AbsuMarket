import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../functions/functions.dart';
import '../screens/view_product.dart';
import '../screens/viewall.dart';
import '../widgets/carousel.dart';
import '../widgets/categories_car.dart';
import '../widgets/recent_card.dart';

class Market extends StatefulWidget {
  Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  List<String> categories = [
    'Electronics',
    'Food',
    'Shoes',
    'Cloths',
    'Cosmetics',
    'Services',
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          //carousel
          Carousel(
            size: size,
          ),

          //
          SizedBox(
            height: size.height * 0.03,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Most Recent',
                  style: GoogleFonts.aBeeZee(fontSize: 16))),
          SizedBox(
            height: size.height * 0.01,
          ),
          FutureBuilder(
              future: getAllProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.length == 0
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 320,
                          width: size.width,
                          child: Column(children: [
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            SizedBox(
                              height: 255,
                              width: size.width,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewProducts(
                                                        product: snapshot
                                                            .data![index],
                                                      )));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: RecentsCard(
                                            model: snapshot.data![index],
                                          ),
                                        ),
                                      )),
                            ),
                          ]),
                        );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error: 404'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: deepBlue,
                    ),
                  );
                }
              }),
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child:
                  Text('Categories', style: GoogleFonts.aBeeZee(fontSize: 16))),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            height: size.height * 0.15,
            width: size.width,
            padding: const EdgeInsets.all(3),
            child: Center(
              child: GridView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 100,
                      crossAxisSpacing: 15),
                  itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewAllProduct(
                                        categoryName: categories[index],
                                      )));
                        },
                        child: CategoriesCard(
                          index: index,
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
