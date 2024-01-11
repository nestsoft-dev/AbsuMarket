import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/functions/functions.dart';
import 'package:absumarket/providers/controller/auth_controller.dart';
import 'package:absumarket/seller/register/seller_reg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/firebase_authproviders.dart';
import '../seller/firebase/firebase_seller.dart';
import '../widgets/details_card.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
          stream: AuthRepository(
                  firebaseAuth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance)
              .getUserData(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    //head
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  snapshot.data!.name,
                                  style: GoogleFonts.aBeeZee(fontSize: 16),
                                ),
                                const Icon(
                                  Icons.verified,
                                  color: deepBlue,
                                  size: 15,
                                )
                              ],
                            ),
                            Text(
                              snapshot.data!.email,
                              style: GoogleFonts.aBeeZee(fontSize: 15),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(),
                            ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(authControllerProvider)
                                      .newfundWallet(
                                          context,
                                          snapshot.data!.email,
                                          '5000',
                                          200,
                                          'ikenna');
                                },
                                child: const Text('Add fund'))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    //stats container
                    Container(
                      height: 90,
                      width: size.width,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 230, 230, 230)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //total Balance
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    snapshot.data!.balance.toStringAsFixed(2),
                                    style: GoogleFonts.aBeeZee(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),

                            //total purchase
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Total Purchase',
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '500',
                                    style: GoogleFonts.aBeeZee(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),

                            //total pending
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Pending Purchase',
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '515',
                                    style: GoogleFonts.aBeeZee(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Make upto 1000 purchases to get verified'),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    //user details

                    const DetailsCard(
                        title: 'Password Reset',
                        des: 'Reset your account password'),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const DetailsCard(
                        title: 'App update',
                        des: 'Read about our privacy policy'),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterSeller()),
                            (route) => false);
                      },
                      child: const DetailsCard(
                          title: 'Become A Seller',
                          des: 'Own your own shop at absu market place'),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    //company details n follow
                    const Divider(
                      color: Colors.grey,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const DetailsCard(
                        title: 'Rate app',
                        des: 'Rate the app on Playstore/IOS store'),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: (){
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'absumarketplace.app@gmail.com',
                          query: encodeQueryParameters(<String, String>{
                            'subject': 'I need help,from ABSU Market Place',
                          }),
                        );

                        launchUrl(emailLaunchUri);
                      },
                      child: const DetailsCard(
                          title: 'Support', des: 'Contact Customer support'),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const DetailsCard(
                        title: 'Security',
                        des: 'Secure app by activating app security'),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () => showSocialMedias(context),
                      child: const DetailsCard(
                          title: 'Get Updates',
                          des: 'Follow us on Various Social media'),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: deepBlue,
                ),
              );
            }
          }),
    );
  }
}
