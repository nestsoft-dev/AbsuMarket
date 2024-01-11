import 'dart:convert';

import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/constants/constant.dart';
import 'package:absumarket/utils/myutils.dart';
import 'package:absumarket/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import '../../models/seller_model.dart';
import '../../pages/nav/bottomnav.dart';
import '../../providers/controller/auth_controller.dart';
import '../../widgets/textinput.dart';
import '../pages/nav/seller_nav.dart';
import 'loginseller.dart';

// class RegisterSeller extends ConsumerStatefulWidget {
//   const RegisterSeller({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _RegisterSellerState();
// }

// class _RegisterSellerState extends ConsumerState<RegisterSeller> {

//   @override
//   Widget build(BuildContext context) {

// }

class RegisterSeller extends StatefulWidget {
  const RegisterSeller({super.key});

  @override
  State<RegisterSeller> createState() => _RegisterSellerState();
}

class _RegisterSellerState extends State<RegisterSeller> {
  final _userStore = TextEditingController();
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;
  String? fcm;

  getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        fcm = value;
      });
      print('FCM Token is $fcm ------------->');
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<SellerModel> addSellerData(BuildContext context, User? user,
      String name, String email, String fcm, String storename) async {
    late SellerModel userModel;
    if (user != null) {
      userModel = SellerModel(
          name: name,
          email: email,
          storeName: storename,
          uuid: user.uid,
          fcm: fcm,
          storeBannerImage: '',
          profilePic: '',
          buyLicencesDate: Timestamp.now(),
          balance: 00.00,
          totalSells: 0,
          pendingOrders: 0,
          rewardsPoints: 0,
          isValid: false);

      print('object registering seller-------->>>>>>>>>>>>>>>>>>>>>>>>>');
      await FirebaseFirestore.instance
          .collection(sellerCollection)
          .doc(user.uid)
          .set(userModel.toMap())
          .then((value) {
        successMessageSnack(
            context, 'Page Created successful', 'Space secured');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNav()),
           );
      });
    }
    return userModel;
  }

  registerSeller(
    BuildContext context,
  ) async {
    try {
      // ref.read(authControllerProvider).registerSeller(
      //     context,
      //     '',
      //     _userStore.text,
      //     FirebaseAuth.instance.currentUser!.uid,
      //     fcm!,
      //     _userEmail.text.trim(),
      //     _userPassword.text.trim());
      final Customer customer =
          Customer(name: _userStore.text, email: _userEmail.text.trim());
      final Flutterwave flutterwave = Flutterwave(
          context: context,
          publicKey: "FLWPUBK_TEST-4b9345ade738326a7c0e12d091bf1acc-X",
          currency: "NGN",
          redirectUrl: "add-your-redirect-url-here",
          txRef: DateTime.now().toIso8601String(),
          amount: '2550',
          customer: customer,
          paymentOptions: "ussd, card, barter, payattitude",
          customization: Customization(title: "My Payment"),
          isTestMode: true);
      final ChargeResponse response = await flutterwave.charge();
      if (response.status == 200) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _userEmail.text.trim(),
                  password: _userPassword.text.trim());

          await addSellerData(context, userCredential.user, '',
                  _userEmail.text.trim(), fcm!, _userStore.text)
              .then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SellerNav())));
        } on FirebaseAuthException catch (e) {
          setState(() {
            isLoading = false;
          });
          errorSnack(context, e.message ?? 'Registration failed.', 'Error');
        }
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
      } else {
        // ignore: use_build_context_synchronously
        setState(() {
          isLoading = false;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _userEmail.text.trim(),
                password: _userPassword.text.trim());

        await addSellerData(context, userCredential.user, '',
                _userEmail.text.trim(), fcm!, _userStore.text)
            .then((value) => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SellerNav())));
        errorSnack(context, 'Payment Failed', 'Payment Error');
        // return;
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: height * 0.05,
            ),

            Lottie.asset('assets/sign_up.json',
                repeat: false, height: height * 0.20),
            SizedBox(
              height: height * 0.01,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome to ABSU',
                      style: GoogleFonts.mulish(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      'Market',
                      style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: deepBlue),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Sign Up to get Seller Place',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),

            //username
            MyTextInput(
              hint: 'Enter Store Name',
              textEditingController: _userStore,
              textInputType: TextInputType.name,
              isPassword: false,
              icon: Iconsax.shop,
            ),

            SizedBox(
              height: height * 0.01,
            ),

            //email
            MyTextInput(
              hint: 'Enter Email',
              textEditingController: _userEmail,
              textInputType: TextInputType.emailAddress,
              isPassword: false,
              icon: Icons.email,
            ),

            SizedBox(
              height: height * 0.01,
            ),

            //password
            MyTextInput(
              onPressed: () {
                setState(() {
                  isPassword = !isPassword;
                });
              },
              hint: 'Create Password',
              textEditingController: _userPassword,
              textInputType: TextInputType.name,
              isPassword: isPassword,
              icon: isPassword ? Iconsax.eye : Iconsax.password_check,
            ),

            SizedBox(
              height: height * 0.05,
            ),

            isLoading
                ? Center(child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: () async {
                      final bool isValid =
                          EmailValidator.validate(_userEmail.text.trim());

                      final bool isPasswordSafe =
                          isPasswordSecure(_userPassword.text.trim());
                      if (_userEmail.text == '' ||
                          _userStore.text == '' ||
                          _userPassword.text == '') {
                        errorSnack(context, 'Please fill the form to proceed',
                            'Error with form');
                        return;
                      } else if (!isValid) {
                        errorSnack(context, 'Please provide a valid email',
                            'Invalid email');
                        return;
                      } else if (_userPassword.text.length < 6) {
                        errorSnack(
                            context,
                            'Password must be more than 6 characters',
                            'Password Error');
                        return;
                      } else if (isPasswordSafe == false) {
                        errorSnack(context, 'Password is not secure',
                            'Use secure password');
                        return;
                      } else {
                        print('Flutter Wave ------------->');

                        setState(() {
                          isLoading = true;
                        });

                        registerSeller(context);
                      }
                    },
                    child: const Button(
                        backroundColor: deepBlue,
                        borderColor: Colors.white,
                        text: 'Register')),

            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginSeller()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: deepBlue),
                    ))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}


// class RegisterSeller extends StatefulWidget {
//   const RegisterSeller({super.key});

//   @override
//   State<RegisterSeller> createState() => _RegisterSellerState();
// }

// class _RegisterSellerState extends State<RegisterSeller> {
 
//   @override
//   Widget build(BuildContext context) {
  
// }
