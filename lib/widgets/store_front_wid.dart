// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/widgets/recent_card.dart';

import '../functions/functions.dart';
import '../screens/view_product.dart';

class StoreFrontCard extends StatelessWidget {
  void Function()? onTap;
  StoreFrontCard({
    Key? key,
    this.onTap,
    required this.category,
    required this.sellerId,
  }) : super(key: key);
  final String category;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getProductForSeller(category, sellerId),
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(category.toUpperCase(),
                              style: GoogleFonts.aBeeZee(fontSize: 16))),
                      SizedBox(
                        height: size.height * 0.01,
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
                                            builder: (context) => ViewProducts(
                                                  product:
                                                      snapshot.data![index],
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
        });
  }
}
