import 'package:absumarket/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/auth/login.dart';
import '../providers/firebase_authproviders.dart';
import '../widgets/recent_card.dart';
import '../widgets/store_front_wid.dart';
import '../widgets/user_or_seller.dart';
import 'view_product.dart';

class SellerShop extends StatefulWidget {
  final String sellerId;
  const SellerShop({super.key, required this.sellerId});

  @override
  State<SellerShop> createState() => _SellerShopState();
}

class _SellerShopState extends State<SellerShop> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Sellers Shop'),
          backgroundColor: Colors.transparent,
        ),
        body: StreamBuilder(
            stream: AuthRepository(
                    firebaseAuth: FirebaseAuth.instance,
                    firebaseFirestore: FirebaseFirestore.instance)
                .getSellershop(widget.sellerId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: height * 0.37,
                          width: width,
                          child: Stack(
                            children: [
                              Container(
                                height: height * 0.30,
                                width: width,
                                color: Colors.blue,
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 5,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        'assets/product.png',
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ))),
                              Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.storeName,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.mulish(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Total Sells ${snapshot.data!.totalSells}',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.podkova(
                                                  fontSize: 18,
                                                  color: deepBlue),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Rating 4.7',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.podkova(
                                                  fontSize: 18,
                                                  color: deepyellow),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //one

                        //one

                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        StoreFrontCard(
                            category: 'Electronics',
                            sellerId: snapshot.data!.uuid),

                        //two
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        StoreFrontCard(
                            category: 'Food', sellerId: snapshot.data!.uuid),

                        //three

                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        StoreFrontCard(
                            category: 'Shoes', sellerId: snapshot.data!.uuid),
                        //for
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        StoreFrontCard(
                            category: 'Cloths', sellerId: snapshot.data!.uuid),

                        //five
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        StoreFrontCard(
                            category: 'Cosmetics',
                            sellerId: snapshot.data!.uuid),

                        //six
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        StoreFrontCard(
                            category: 'Services',
                            sellerId: snapshot.data!.uuid),
                      ]),
                );
              } else if (snapshot.hasError) {
                return const Center(
                    child: UserOrSeller(
                  name:
                      'You can\'t login with clients\'s details in seller app',
                  destinaltion: LoginPage(),
                ));

                // return const Center(
                //   child: Text('Error: 404'),
                // );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
