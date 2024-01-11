import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/seller/register/loginseller.dart';
import 'package:absumarket/widgets/user_or_seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/auth/login.dart';
import '../../pages/nav/bottomnav.dart';
import '../../providers/firebase_authproviders.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  List<String> header = ['Total Sells', 'Pending orders'];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
          stream: AuthRepository(
                  firebaseAuth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance)
              .getSellerData(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Total Earning',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          '₦${snapshot.data!.balance}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 350,
                      child: GridView.builder(
                          itemCount: 2,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (_, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: deepBlue,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          header[index],
                                          style: GoogleFonts.podkova(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          index == 0
                                              ? snapshot.data!.totalSells
                                                  .toString()
                                              : snapshot.data!.pendingOrders
                                                  .toString(),
                                          style: GoogleFonts.podkova(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    )
                  ]),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                  child: UserOrSeller(
                name: 'You can\'t login with clients\'s details in seller app',
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
          }),
    );
  }
}
