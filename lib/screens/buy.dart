// ignore_for_file: public_member_api_docs, sort_constructors_first, void_checks
import 'package:absumarket/providers/firebase_authproviders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/models/productmodel.dart';
import 'package:absumarket/utils/myutils.dart';
import 'package:absumarket/widgets/textinput.dart';

import '../functions/functions.dart';

class BuyItem extends StatefulWidget {
  const BuyItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

  @override
  State<BuyItem> createState() => _BuyItemState();
}

class _BuyItemState extends State<BuyItem> {
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _coupon = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Make Payment'),
        ),
        body: StreamBuilder(
            stream: AuthRepository(
                    firebaseAuth: FirebaseAuth.instance,
                    firebaseFirestore: FirebaseFirestore.instance)
                .getUserData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.3,
                          child: Lottie.asset('assets/about_purchasing.json',
                              repeat: false),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Please Enter Address Below'),
                        const SizedBox(
                          height: 2,
                        ),
                        MyTextInput(
                            hint: 'Enter delivery address below',
                            textEditingController: _address,
                            textInputType: TextInputType.streetAddress,
                            isPassword: false,
                            icon: Iconsax.house),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Please Enter Phone Number'),
                        const SizedBox(
                          height: 2,
                        ),
                        MyTextInput(
                            hint: 'Enter Phone Number',
                            textEditingController: _phone,
                            textInputType: TextInputType.number,
                            isPassword: false,
                            icon: Icons.phone),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Please Enter Coupon Code'),
                        const SizedBox(
                          height: 2,
                        ),
                        MyTextInput(
                            hint: 'Enter Coupon Code',
                            textEditingController: _coupon,
                            textInputType: TextInputType.name,
                            isPassword: false,
                            icon: Iconsax.discount_circle),
                        const SizedBox(
                          height: 20,
                        ),
                        _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: deepBlue,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (_address.text.isEmpty ||
                                      _phone.text.isEmpty) {
                                    return errorSnack(
                                        context,
                                        'Please Provide a valid input',
                                        'User Error');
                                  }
                                  if (_phone.text.length <= 10) {
                                    return errorSnack(
                                        context,
                                        'Please Provide a valid Number',
                                        'User Error');
                                  } else if (widget.product.price >
                                      snapshot.data!.balance) {
                                    return errorSnack(
                                        context,
                                        'Please your balance is low',
                                        'User Error');
                                  } else {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (_coupon.text.isNotEmpty &&
                                        _coupon.text ==
                                            widget.product.productCounpon) {
                                      succesPurchased(
                                          context,
                                          snapshot.data!,
                                          _coupon.text,
                                          _phone.text,
                                          widget.product);
                                    } else if (_coupon.text.isEmpty) {
                                      succesPurchased(
                                          context,
                                          snapshot.data!,
                                          _coupon.text,
                                          _phone.text,
                                          widget.product);
                                    } else {
                                      return errorSnack(
                                          context,
                                          'Please your balance is low',
                                          'User Error');
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: deepBlue,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Text(
                                      'Make Payment',
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Please Note that this action can not be reversed',
                          style: GoogleFonts.aBeeZee(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error: 404'));
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: deepBlue,
                  ),
                );
              }
            }));
  }
}
